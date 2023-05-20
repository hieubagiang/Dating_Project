import string
from datetime import datetime

from faker import Faker
from pandas.core.methods.to_dict import to_dict


class UserScore:
    def __init__(self, user_id: string, score: float, create_at: datetime):
        self.user_id = user_id
        self.score = score
        self.create_at = datetime.now() if create_at is None else create_at


    @staticmethod
    def from_json(json_data):
        return UserScore(
            user_id=json_data['user_id'],
            score=json_data['score'],
            create_at=datetime.fromisoformat(json_data['create_at']) if json_data['create_at'] else None,
        )

    def to_dict(self):
        return {
            "user_id": self.user_id,
            "score": self.score,
            "create_at": self.create_at.isoformat(),
        }

    def __str__(self):
        return to_dict(self)

