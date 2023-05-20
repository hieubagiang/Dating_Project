from flask import request, Blueprint
from api.middleware.intercepter import require_authenticate
from api.notification.notification_controller import NotificationController

notification_bp = Blueprint('notification', __name__)

@notification_bp.route('/notification/send_notification', methods=['POST'])
# @require_authenticate
def when_send_noti():
    return NotificationController.send_noti_to_user(request)
