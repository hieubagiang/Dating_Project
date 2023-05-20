import json
from datetime import datetime

from utils import date_time_parser


class PositionModelEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, datetime):
            return obj.isoformat()
        elif isinstance(obj, PositionModel):
            return obj.__dict__
        else:
            return json.JSONEncoder.default(self, obj)


class PositionModel:
    def __init__(self, latitude: float, longitude: float, address: str, create_at: datetime, update_at: datetime):
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
        self.create_at = create_at
        self.update_at = update_at

    @staticmethod
    def from_json(json_data):
        return PositionModel(
            latitude=json_data['latitude'],
            longitude=json_data['longitude'],
            address=json_data['address'],
            create_at=date_time_parser(json_data['create_at']) if 'create_at' in json_data else None,
            update_at=date_time_parser(json_data['update_at']) if 'update_at' in json_data else None,
        )

    def to_dict(self):
        return {
            "latitude": self.latitude,
            "longitude": self.longitude,
            "address": self.address,
            "create_at": self.create_at.isoformat() if self.create_at is not None else None,
            "update_at": self.update_at.isoformat() if self.update_at is not None else None,
        }
    def to_json(self):
        return json.dumps(self, cls=PositionModelEncoder)
    def pair(self):
        return self.latitude, self.longitude

    def __str__(self):
        return str(self.to_dict())
