import requests
from firebase_admin.messaging import Notification

from api import headers, db
from api.models.notification_payload import NotificationPayload, CallModel, NotificationType
from api.models.payment_model import PaymentModel


class NotificationController:
    @staticmethod
    def create_notification(tokens: list, notification_payload: NotificationPayload, notification: Notification):
        show_notification = notification is not None
        data = {
            "priority": "HIGH",
            "data": notification_payload.to_message(),
            "notification": {
                "title": notification.title,
                "body": notification.body,
                "content_available": True,
                "alert":True,
                "tag":notification_payload.notification_type.value
            } if show_notification else None,
            "registration_ids": tokens
        }

        response = requests.post('https://fcm.googleapis.com/fcm/send', headers=headers, json=data)

        if response.status_code == 200:
            print('Notification sent successfully')
        else:
            print('Error sending notification: ', response.text)

    @staticmethod
    def create_dynamic_notification(tokens: list, notification_payload: dict,notification : dict):
        data = {
            "priority": "HIGH",
            "data": notification_payload,
            "notification":notification if notification else None,
            "registration_ids": tokens
        }

        response = requests.post('https://fcm.googleapis.com/fcm/send', headers=headers, json=data)

        if response.status_code == 200:
            print('Notification sent successfully')
            return response.json()
        else:
            print('Error sending notification: ', response.text)
            return response.json()

    @staticmethod
    def send_noti_to_user(request):
        body = request.json
        user_ids = body['user_ids']
        data = body['data']
        notification = body['notification']
        # get token from user_ids in db
        tokens= []
        query = db.collection('users').where('id', 'in', user_ids).stream()
        for doc in query:
            tokens.append(doc.to_dict()['token'])
        result = NotificationController.create_dynamic_notification(tokens=tokens, notification_payload=data,notification=notification)
        return result
        # send notification

    @staticmethod
    def create_noti_from_payment(token: str, payment_model: PaymentModel):
        NotificationController.create_notification(token=token,
                            notification_payload=NotificationPayload(notification_type=NotificationType.payment,
                                                                     payment_model=payment_model),
                            notification=payment_model.get_notification_message())

    @staticmethod
    def create_noti_from_call(token: str, call_model: CallModel):
        NotificationController.create_notification(token=token,
                            notification_payload=NotificationPayload(notification_type=NotificationType.call,
                                                                     call_model=call_model),
                            notification=call_model.get_notification_message())
