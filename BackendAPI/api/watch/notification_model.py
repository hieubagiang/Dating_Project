from firebase_admin import messaging

from api.models.notification_payload import CallModel, NotificationPayload, NotificationType


def send_call_notification(token, call_model: CallModel):
    try:
        payload = NotificationPayload(notification_type=NotificationType.call, call_model=call_model)
        if payload.call_model.get_notification_message() is not None:
            message = messaging.Message(
                notification=payload.call_model.get_notification_message(),
                android=messaging.AndroidConfig(
                    priority='high',
                    notification=messaging.AndroidNotification(
                        sound='notification_sound.mp3',
                        click_action='FLUTTER_NOTIFICATION_CLICK',
                        tag='incoming_call',
                        # channel_id='incoming_call'
                    ),
                ),
                data=payload.to_message(),
                token=token,
            )
        else:
            message = messaging.Message(
                android=messaging.AndroidConfig(
                    priority='high',
                    notification=messaging.AndroidNotification(
                        sound='notification_sound.mp3',
                        click_action='FLUTTER_NOTIFICATION_CLICK',
                        tag='incoming_call',
                        # channel_id='incoming_call'
                    ),
                ),
                data=payload.to_message(),
                token=token,
            )

        response = messaging.send(message)
        print('Successfully sent message:', response)
    except Exception as e:
        print('Error sending message:', e)
