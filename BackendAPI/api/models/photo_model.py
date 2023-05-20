import json
from datetime import datetime
from enum import Enum

from faker import Faker


class PhotoModelEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, Enum):
            return obj.value
        elif isinstance(obj, datetime):
            return obj.isoformat()
        elif isinstance(obj, PhotoModel):
            return obj.__dict__
        else:
            return json.JSONEncoder.default(self, obj)



class PhotoModel:
    def __init__(self, photo_id: int, url: str, create_at: datetime, update_at: datetime):
        self.id = photo_id
        self.url = url
        self.create_at = create_at
        self.update_at = update_at

    @staticmethod
    def from_json(json_data):
        return PhotoModel(
            photo_id=json_data['id'],
            url=json_data['url'],
            create_at=datetime.fromisoformat(json_data['create_at']) if json_data['create_at'] else None,
            update_at=datetime.fromisoformat(json_data['update_at']) if json_data['update_at'] else None,
        )
    def to_json(self):
        json.dumps(self, cls=PhotoModelEncoder)
    def to_dict(self):
        return {
            'id': self.id,
            'url': self.url,
            'create_at': self.create_at.isoformat() if self.create_at else None,
            'update_at': self.update_at.isoformat() if self.update_at else None,
        }


    @staticmethod
    def fake():
        fake = Faker(locale="vi_VN")
        return PhotoModel(
            photo_id=fake.random.randint(1, 100000),
            url=fake.image_url(),
            create_at=datetime.now(),
            update_at=datetime.now(),
        )
