from flask import Blueprint, request

from api.middleware.intercepter import require_authenticate
from api.payment.payment_controller import payment_return, payment_ipn, payment_process, get_payment_detail, \
    get_payment_history

# get Recommend with filter
payment_bp = Blueprint('payment', __name__)


@payment_bp.route('/payment/payment_process', methods=['POST'])
@require_authenticate
def on_payment_process():
    return payment_process(request)


@payment_bp.route('/payment/payment_return', methods=['GET'])
def on_payment_return():
    return payment_return(request)


# payment_ipn
@payment_bp.route('/payment/payment_ipn', methods=['GET'])
def on_payment_ipn():
    return payment_ipn(request)
@payment_bp.route('/payment/histories/<string:payment_id>', methods=['GET'])
@require_authenticate
def on_get_payment_detail(payment_id: str):
    return get_payment_detail(payment_id)


#get payment history of user
@payment_bp.route('/payment/histories', methods=['GET'])
@require_authenticate
def on_get_payment_history():
    return get_payment_history(request)
