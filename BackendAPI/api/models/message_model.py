import json
from dataclasses import dataclass
from datetime import datetime
from enum import Enum
from typing import Optional, List

from api.models.notification_payload import CallModel


class MessageType(Enum):
    TEXT = 'text'
    IMAGE = 'image'
    VIDEO = 'video'
    FILE = 'file'
    CALL = 'call'


class AttachmentType(Enum):
    IMAGE = "image"
    VIDEO = "video"
    FILE = "file"


@dataclass
class Attachment:
    url: str
    type: AttachmentType
    metadata: dict = None


class MessageModelEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, Enum):
            return obj.value
        elif isinstance(obj, datetime):
            return obj.isoformat()

        elif isinstance(obj, CallModel):
            return obj.__dict__
        else:
            return json.JSONEncoder.default(self, obj)


@dataclass
class MessageModel:
    message_id: str
    sender_name: str
    sender_id: str
    message_type: MessageType
    text: Optional[str] = None
    avatar_url: Optional[str] = None
    profile_photo: Optional[bytes] = None
    attachments: List[Attachment] = None
    create_at: datetime = datetime.now()
    update_at: Optional[datetime] = None
    call_model: Optional[CallModel] = None

    def to_json(self):
        return json.dumps(self, cls=MessageModelEncoder)
