import threading

from api import db
from api.models.notification_payload import *
from api.notification.notification_controller import NotificationController
from api.watch.notification_model import *


# Create an Event for notifying main thread.
callback_done2 = threading.Event()


# Create a callback on_snapshot function to capture changes
def on_snapshot(col_snapshot, changes, read_time):
    print(u'Callback received query snapshot.')
    for change in changes:
        call_data = change.document.to_dict()
        try:
            call_model = CallModel.from_dict(call_data)
            if change.type.name == 'ADDED':
                print(f'New : {change.document}')
                # get call data
                print(f"Call ID: {call_model.call_id}")
                print(f"Status: {call_data.get('call_status')}")
                # compare call created time with current time > 30s => update call status to unanswered
                # if ringing => send notification
                if call_model.call_status == CallStatusType.ringing:
                    # send new call notification
                    # get token of callee from collection users
                    callee_ref = db.collection('users').document(call_model.receiver_id)
                    callee_data = callee_ref.get().to_dict()
                    token = callee_data.get('token')
                    NotificationController.create_noti_from_call(token,call_model)
                    # update field callModel in collection channels/channelId/messages/messageId

            if change.type.name == 'MODIFIED':
                # send call accepted notification
                # get token of caller from collection users
                caller_token = db.collection('users').document(call_model.caller_id).get().to_dict().get('token')
                NotificationController.create_noti_from_call(caller_token,call_model)

                if call_model.call_status == CallStatusType.unanswered:
                    receive_token = db.collection('users').document(call_model.receiver_id).get().to_dict().get('token')
                    NotificationController.create_noti_from_call(receive_token,call_model)


                # update field callModel in collection channels/channelId/messages/messageId
                channel_ref = db.collection('channels').document(call_model.channel_id)
                message_data = channel_ref.collection('messages').document(call_model.message_id).get().to_dict()
                message_data['call_model'] = call_model.to_dict()
                channel_ref.collection('messages').document(call_model.message_id).set(message_data, merge=True)
        except Exception as e:
            print('exception on listening call')
            print('issue on data: '+ call_data)
            print(repr(e))



# set status to 'notified'
# elif change.type.name == 'REMOVED':
#     print(f'Removed city: {change.document}')
#     callback_done2.set()

def start_watch():
    print(u'Watch started')
    query_watch = col_query.on_snapshot(on_snapshot)
    return query_watch
col_query = db.collection(u'calls')

# Watch the collection query

#
# while not callback_done2.is_set():
#     time.sleep(1)
#     print("Waiting...")
# [END listen_document]

# payload = NotificationPayload(notification_type=NotificationType.call, call_model=incoming_call)
#
# send_call_notification(
#     'cKWB21cfQOGPrFdxeLhh6F:APA91bH-cSVvDwJyweVTEhuqitzzgSYMimGZjPFLNqUVEGtHRkeScRyjAEViJ0iPFFJt8Mz07U12q5x_tLHahk7AHwnzC4W5UbRFzGCdWKB1T39kx-mBzFVkB750aNKpOi3AsEFVU8bc',
#     payload)
# exit(0)
