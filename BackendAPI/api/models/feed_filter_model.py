import json
from datetime import datetime
from enum import Enum


from api.models.age_range import AgeRangeModel


class FeedFilterModelEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, Enum):
            return obj.value
        elif isinstance(obj, datetime):
            return obj.isoformat()
        elif isinstance(obj, FeedFilterModel):
            return obj.__dict__
        elif isinstance(obj, AgeRangeModel):
            return obj.__dict__
        else:
            return json.JSONEncoder.default(self, obj)


class FeedFilterModel:
    def __init__(self, distance: float = None, interested_in_gender: int = None,
                 age_range: AgeRangeModel = None, create_at: datetime = None):
        self.distance = distance
        self.interested_in_gender = interested_in_gender
        self.age_range = age_range
        self.create_at = create_at

    @staticmethod
    def from_json(data):
        ageRange = None
        if "age_range" in data:
            ageRange = AgeRangeModel.from_json(data["age_range"])

        return FeedFilterModel(distance=data.get("distance"),
                               interested_in_gender=data.get("interested_in_gender"),
                               age_range=ageRange,
                               create_at=datetime.fromisoformat(
                                   data.get("create_at")) if 'create_at' in data and data.get("create_at") is not None else None, )

    def to_json(self):
        return json.dumps(self, cls=FeedFilterModelEncoder)

    def to_dict(self):
        return json.loads(self.to_json())

    def get_interested_in_gender(self):
        return 'male' if self.interested_in_gender == 1 else 'female'
