import hashlib
import hmac
from datetime import datetime

from firebase_admin import firestore
from flask import Request

import utils
from api.models.api_error_response import ApiResponse, ApiErrorResponse
from api.models.payment_model import PaymentModel, PaymentStatusType
from api.models.user_model import UserModel
from api.notification.notification_controller import NotificationController
from api.payment.payment_config import *
from api.payment.vnpay import vnpay
from api.utils.utils import get_pagination_params

db = firestore.client()


# for delete empty name
# delete_docs_without_name_field("users")

def hmacsha512(key, data):
    byteKey = key.encode('utf-8')
    byteData = data.encode('utf-8')
    return hmac.new(byteKey, byteData, hashlib.sha512).hexdigest()


def getUser(user_id):
    users_collection = db.collection("users")
    doc = users_collection.document(user_id).get()
    if doc.exists:
        return UserModel.from_json(doc.to_dict())
    else:
        return None


def createPagination(total, page, limit):
    pagination = {'total': total, 'page': page, 'limit': limit}
    return pagination


def limitDocs(docs, page, limit):
    start = (page - 1) * limit
    end = start + limit
    # return error if page is out of range
    return docs[start:end], createPagination(len(docs), page, limit)


# def createPaymentLink(user_id, premium_package):
#     # create https request to payment service
#     url = 'https://sandbox.vnpayment.vn/tryitnow/Home/CreateOrder'
#     # request and get response
#     response = requests.get(url,verify=False)
#     soup = BeautifulSoup(response.content, 'html.parser')
#     input_element = soup.find('input', attrs={'name': '__RequestVerificationToken'})
#     amount = 1000000
#     if input_element:
#         request_verification_token = input_element['value']
#         data = {
#             'ordertype': 'purchase_subscription',
#             'Amount': amount,
#             'OrderDescription': 'test3',
#             'bankcode': '',
#             'language': 'vn',
#             '__RequestVerificationToken': input_element['value']
#         }
#         create_res = requests.post(url, data=data, verify=False,allow_redirects=False)
#         paymentLink = create_res.headers['Location']
#         #parse payment link get query params
#         parsed_url = urlparse(paymentLink)
#         # vnp_Amount=100000000&vnp_CreateDate=20230502180834&vnp_CurrCode=VND&vnp_ExpireDate=20230502182334&vnp_IpAddr=42.115.135.174&vnp_Locale=vn&vnp_OrderInfo=test3&vnp_OrderType=purchase_subscription&vnp_ReturnUrl=https%3A%2F%2Fsandbox.vnpayment.vn%2Ftryitnow%2FHome%2FVnPayReturn&vnp_TmnCode=2QXUI4J4&vnp_TxnRef=
#         # convert to hash map
#         query_params = parse_qs(parsed_url.query)
#         query_map = {k: v[0] for k, v in query_params.items()}
#         transaction_id = utils.generate_transaction_id()
#         print(transaction_id)
#         print(query_map)
#         print(paymentLink)
#     else:
#         print('Input element not found')

def get_client_ip(request: Request):
    x_forwarded_for = request.headers.get('X-Forwarded-For')
    if x_forwarded_for:
        ip = x_forwarded_for.split(',')[0]
    else:
        ip = request.remote_addr
    return ip


def get_vnpay_link(order_id, amount, order_desc, order_type, bank_code, language, ipaddr):
    # Build URL Payment
    vnp = vnpay()
    vnp.requestData['vnp_Version'] = '2.1.0'
    vnp.requestData['vnp_Command'] = 'pay'
    vnp.requestData['vnp_TmnCode'] = VNPAY_TMN_CODE
    vnp.requestData['vnp_Amount'] = amount * 100
    vnp.requestData['vnp_CurrCode'] = 'VND'
    vnp.requestData['vnp_TxnRef'] = order_id
    vnp.requestData['vnp_OrderInfo'] = order_desc
    vnp.requestData['vnp_OrderType'] = order_type
    # Check language, default: vn
    if language and language != '':
        vnp.requestData['vnp_Locale'] = language
    else:
        vnp.requestData['vnp_Locale'] = 'vn'
        # Check bank_code, if bank_code is empty, customer will be selected bank on VNPAY
    if bank_code and bank_code != "":
        vnp.requestData['vnp_BankCode'] = bank_code

    vnp.requestData['vnp_CreateDate'] = datetime.now().strftime('%Y%m%d%H%M%S')  # 20150410063022
    vnp.requestData['vnp_IpAddr'] = ipaddr
    vnp.requestData['vnp_ReturnUrl'] = VNPAY_RETURN_URL
    vnpay_payment_url = vnp.get_payment_url(VNPAY_PAYMENT_URL, VNPAY_HASH_SECRET_KEY)
    return vnpay_payment_url


def payment_process(request: Request):
    # Post Method
    body = request.get_json()
    user_id = request.user_id
    premium_package_slug = body['premium_package']
    # search value in subscription_packages collection where slug = premium_package_slug
    premium_package = db.collection('subscription_packages').where('slug', '==', premium_package_slug).get()
    if len(premium_package) == 0:
        return ApiErrorResponse(error_message='Gói dịch vụ không tồn tại', code="400").__dict__
    premium_package = premium_package[0].to_dict()
    price = premium_package['price']
    order_id = utils.generate_transaction_id()
    # create payment history in database
    # use firebase to generate id
    payment_id = db.collection('payment_histories').document().id
    payment_model = PaymentModel(payment_id=payment_id, user_id=user_id, transaction_id=order_id,
                                 status=PaymentStatusType.pending, payment_method='vnpay',
                                 subscription_package=premium_package,
                                 created_at=datetime.now(),
                                 updated_at=datetime.now()
                                 )
    db.collection('payment_histories').document(payment_id).set(payment_model.to_dict())
    user = getUser(user_id)
    if user:
        vnpay_payment_url = get_vnpay_link(order_id=order_id, amount=price,
                                           order_desc='Thanh toán gói ' + premium_package['name'] + '',
                                           order_type='purchase_subscription',
                                           bank_code='', language='vn',
                                           ipaddr=get_client_ip(request))
        return ApiResponse(data={'payment_model': payment_model.to_dict(), 'payment_url': vnpay_payment_url}).to_dict()
    else:
        return ApiErrorResponse(error_message='Người dùng không tồn tại', code="400").__dict__


def payment_return(request: Request):
    inputData = request.args.to_dict()
    if inputData:
        vnp = vnpay()
        vnp.responseData = inputData
        order_id = inputData['vnp_TxnRef']
        amount = int(inputData['vnp_Amount']) / 100
        order_desc = inputData['vnp_OrderInfo']
        vnp_TransactionNo = inputData['vnp_TransactionNo']
        vnp_ResponseCode = inputData['vnp_ResponseCode']
        vnp_TmnCode = inputData['vnp_TmnCode']
        vnp_PayDate = inputData['vnp_PayDate']
        vnp_BankCode = inputData['vnp_BankCode']
        vnp_CardType = inputData['vnp_CardType']
        payment_model = db.collection('payment_histories').where('transaction_id', '==', order_id) \
            .where('status', '==',
                   PaymentStatusType.pending.value).get()
        if len(payment_model) > 0:
            payment_model = payment_model[0].to_dict()
            payment_model = PaymentModel.from_dict(payment_model)

            if payment_model.status != PaymentStatusType.pending:
                return {"RspCode": "02", "Message": "Order Already Update"}
        else:
            return {"RspCode": "01", "Message": "Order not found"}

        if vnp.validate_response(VNPAY_HASH_SECRET_KEY):
            if vnp_ResponseCode == "00":
                print('Payment Success. Your code implement here')
                # update payment status success
                payment_model.set_success()
                db.collection('payment_histories').document(payment_model.payment_id).set(
                    payment_model.to_dict(), merge=True)
                # update user premium
                user = getUser(payment_model.user_id)
                if user:
                    user.addPremium(payment_model.subscription_package.duration_in_days)
                    db.collection('users').document(user.id).set(user.to_dict(), merge=True)
                    # create notification for user
                    if len(user.token) > 0:
                        NotificationController.create_noti_from_payment(token=user.token[0],
                                                                        payment_model=payment_model)

                return ApiResponse(data={"title": "Kết quả thanh toán",
                                         "result": "Thành công", "order_id": order_id,
                                         "amount": amount,
                                         "order_desc": order_desc,
                                         "vnp_TransactionNo": vnp_TransactionNo,
                                         "vnp_ResponseCode": vnp_ResponseCode}).to_dict()
            else:
                print('Payment Error. Your code implement here')
                payment_model.set_failed()
                db.collection('payment_histories').document(payment_model.payment_id).set(
                    payment_model.to_dict(), merge=True)

            return ApiResponse(data={"title": "Kết quả thanh toán",
                                     "result": "Lỗi", "order_id": order_id,
                                     "amount": amount,
                                     "order_desc": order_desc,
                                     "vnp_TransactionNo": vnp_TransactionNo,
                                     "vnp_ResponseCode": vnp_ResponseCode}).to_dict()
        else:
            return ApiResponse(data={"title": "Kết quả thanh toán",
                                     "result": "Lỗi", "order_id": order_id,
                                     "amount": amount,
                                     "order_desc": order_desc,
                                     "vnp_TransactionNo": vnp_TransactionNo,
                                     "vnp_ResponseCode": vnp_ResponseCode}).to_dict()
    else:
        return ApiErrorResponse(error_message='Không có dữ liệu trả về', code="400").to_dict()


def get_payment_detail(payment_id: str):
    # get payment detail from payment_histories collection with document id = payment_id
    payment = db.collection('payment_histories').document(payment_id).get()
    if payment is not None:
        payment = payment.to_dict()
        return ApiResponse(data=payment).to_dict()
    else:
        return ApiErrorResponse(error_message='Không tìm thấy thông tin thanh toán', code="400").to_dict()


def payment_ipn(request: Request):
    inputData = request.args
    if inputData:
        vnp = vnpay()
        vnp.responseData = inputData.to_dict()
        order_id = inputData['vnp_TxnRef']
        amount = inputData['vnp_Amount']
        order_desc = inputData['vnp_OrderInfo']
        vnp_TransactionNo = inputData['vnp_TransactionNo']
        vnp_ResponseCode = inputData['vnp_ResponseCode']
        vnp_TmnCode = inputData['vnp_TmnCode']
        vnp_PayDate = inputData['vnp_PayDate']
        vnp_BankCode = inputData['vnp_BankCode']
        vnp_CardType = inputData['vnp_CardType']
        if vnp.validate_response(VNPAY_HASH_SECRET_KEY):
            # Check & Update Order Status in your Database
            # Your code here
            first_time_update = True
            totalamount = True
            payment_model = db.collection('payment_histories').where('transaction_id', '==', order_id).get()
            if len(payment_model) > 0:
                payment_model = payment_model[0].to_dict()
                payment_model = PaymentModel.from_dict(payment_model)
                # if payment_model.status != PaymentStatusType.pending:
                #     return {"RspCode": "02", "Message": "Order Already Update"}
            else:
                return {"RspCode": "01", "Message": "Order not found"}
            if totalamount:
                if first_time_update:
                    if vnp_ResponseCode == '00':
                        print('Payment Success. Your code implement here')
                        # update payment status success
                        payment_model.set_success()
                        db.collection('payment_histories').document(payment_model.payment_id).set(
                            payment_model.to_dict(), merge=True)
                        # update user premium
                        user = getUser(payment_model.user_id)
                        if user:
                            user.addPremium(payment_model.subscription_package.duration_in_days)
                            db.collection('users').document(user.id).set(user.to_dict(), merge=True)
                            # create notification for user
                            if len(user.token) > 0:
                                NotificationController.create_noti_from_payment(token=user.token[0],
                                                                                payment_model=payment_model)

                    else:
                        print('Payment Error. Your code implement here')
                        payment_model.set_failed()
                        db.collection('payment_histories').document(payment_model.payment_id).set(
                            payment_model.to_dict(), merge=True)

                    # Return VNPAY: Merchant update success
                    result = {'RspCode': '00', 'Message': 'Confirm Success'}
                else:
                    # Already Update
                    result = {'RspCode': '02', 'Message': 'Order Already Update'}
            else:
                # invalid amount
                result = {'RspCode': '04', 'Message': 'invalid amount'}
        else:
            # Invalid Signature
            result = {'RspCode': '97', 'Message': 'Invalid Signature'}
    else:
        result = {'RspCode': '99', 'Message': 'Invalid request'}

    return result


# link = get_vnpay_link('123', 1000000, 'test', 'purchase_subscription', '', 'vn','192.168.0.123')
# print(link)
# exit()
# print(output)


def get_payment_history(request: Request):
    user_id = request.user_id
    # have pagination with page and limit default value is 1 and 10
    page, limit = get_pagination_params(request)
    # get payment history from payment_histories collection
    docs = db.collection('payment_histories').where('user_id', '==', user_id)
    size = len(docs.get())
    payment_histories = docs.order_by(
        'created_at', direction='DESCENDING').limit(limit).offset((page - 1) * limit).get()

    payment_histories = [payment.to_dict() for payment in payment_histories]
    pagination = createPagination(size, page, limit)

    # create pagination
    return ApiResponse(data={
        "data": payment_histories,
        "pagination": pagination
    }).to_dict()
