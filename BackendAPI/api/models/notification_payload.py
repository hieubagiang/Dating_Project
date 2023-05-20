import json
import string
from dataclasses import dataclass
from datetime import datetime
from enum import Enum

from firebase_admin.messaging import Notification

from api.models.payment_model import PaymentModel


class BasicUser:
    def __init__(self, id, name, avatar):
        self.id = id
        self.name = name
        self.avatar = avatar

    def from_dict(data: dict):
        name = data["name"]
        id = data["id"]
        avatar = data["avatar"]
        return BasicUser(name=name, avatar=avatar, id=id)


class NotificationType(Enum):
    new_message = 'new_message'
    call = 'call'
    payment = 'payment'


# enum CallStatusType { calling, ended, rejected, unanswered }
class CallStatusType(Enum):
    ringing = 'ringing'
    accepted = 'accepted'
    started = 'started'
    ended = 'ended'
    rejected = 'rejected'
    unanswered = 'unanswered'

    def __str__(self):
        return self.value

    def __dict__(self):
        return self.value

    def from_dict(status_dict: dict):
        return CallStatusType[status_dict]


# enum CallType { voice, video }
class CallType(Enum):
    voice = 'voice'
    video = 'video'

    def __str__(self):
        return self.value

    def __dict__(self):
        return self.value

    def from_dict(status_dict: dict):
        return CallType[status_dict]


class CallModelEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, Enum):
            return obj.value
        elif isinstance(obj, datetime):
            return obj.isoformat()
        elif isinstance(obj, CallModel):
            return obj.__dict__
        elif isinstance(obj, NotificationType):
            return obj.__dict__
        elif isinstance(obj, NotificationPayload):
            return obj.__dict__
        elif isinstance(obj, BasicUser):
            return obj.__dict__
        else:
            return json.JSONEncoder.default(self, obj)


@dataclass
class CallModel:
    call_id: str
    message_id: str
    channel_id: str
    caller_id: str
    caller: BasicUser
    receiver_id: str
    receiver: BasicUser
    call_status: CallStatusType
    callType: CallType
    start_time: datetime = None
    end_time: datetime = None

    def to_json(self):
        return json.dumps(self, cls=CallModelEncoder)
    def to_dict(self):
        return json.loads(self.to_json())
    def get_notification_message(self):
        title = None
        body = None
        if self.call_status == CallStatusType.ringing:
            title = "Incoming Call"
            body = f"You have a new call from {self.caller.name}"
        return Notification(title=title, body=body) if title and body else None

    def from_dict(self: dict):
        if 'call_id' in self:
            return CallModel(call_id=self['call_id'],
                             caller_id=self['caller_id'],
                             channel_id=self['channel_id'],
                             message_id=self['message_id'] if 'message_id' in self else None,
                             caller=BasicUser.from_dict(self['caller']),
                             receiver_id=self['receiver_id'],
                             receiver=BasicUser.from_dict(self['receiver']),
                             call_status=CallStatusType.from_dict(self['call_status']),
                             start_time=datetime.fromisoformat(self['start_time']) if 'start_time' in self and self['start_time'] is not None else None,
                             end_time=datetime.fromisoformat(self['end_time']) if 'end_time' in self and self['end_time'] is not None else None,
                             callType=CallType.from_dict(self['call_type'])if 'call_type' in self and self['call_type'] is not None else CallType.voice,
                             )

        return self

    @staticmethod
    def from_json(json_str):
        return json.loads(json_str, object_hook=CallModel.from_dict)


class NotificationPayloadEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, Enum):
            return obj.value
        elif isinstance(obj, NotificationPayload):
            return obj.__dict__
        elif isinstance(obj, CallModel):
            return obj.to_json()
        else:
            return json.JSONEncoder.default(self, obj)


@dataclass
class NotificationPayload:
    notification_type: NotificationType
    call_model: CallModel = None
    payment_model: PaymentModel = None
    click_action: string = 'g'

    def to_json(self):
        return json.dumps(self, cls=CallModelEncoder)

    def to_dict(self):
        return json.loads(self.to_json())

    def to_message(self):
        data =  {"notification_type": self.notification_type.value,
                "click_action": self.click_action}
        if self.call_model is not None:
            data["call_model"] = self.call_model.to_json()
        if self.payment_model is not None:
            data["payment_model"] = self.payment_model.to_json()
        return data

