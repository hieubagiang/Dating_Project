import json
import string
from datetime import datetime
from enum import Enum


class HobbyModelEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, Enum):
            return obj.value
        elif isinstance(obj, datetime):
            return obj.isoformat()
        elif isinstance(obj, HobbyModel):
            return obj.__dict__
        else:
            return json.JSONEncoder.default(self, obj)


class HobbyModel:
    def __init__(self, id: string, name: string):
        self.id = id
        self.name = name

    @staticmethod
    def from_json(json_data: dict):
        return HobbyModel(
            id=json_data['id'],
            name=json_data['name'],
        )
    def to_json(self):
        return json.dumps(self, cls=HobbyModelEncoder)
    def to_dict(self):
        return json.loads(self.to_json())


