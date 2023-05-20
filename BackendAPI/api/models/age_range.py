import json
from datetime import datetime
from enum import Enum


class AgeRangeModelEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, Enum):
            return obj.value
        elif isinstance(obj, datetime):
            return obj.isoformat()
        elif isinstance(obj, AgeRangeModel):
            return obj.__dict__
        else:
            return json.JSONEncoder.default(self, obj)
class AgeRangeModel:
    def __init__(self, start: int, end: int, create_at: datetime = None, update_at: datetime = None):
        self.start = start
        self.end = end

    @staticmethod
    def from_json(json_data):
        return AgeRangeModel(
            start=json_data['start'],
            end=json_data['end'],
        )

    def to_json(self):
        return json.dumps(self, cls=AgeRangeModelEncoder)

    def to_dict(self):
        return json.loads(self.to_json())

