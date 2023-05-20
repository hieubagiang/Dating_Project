import random
from datetime import datetime
from dataclasses import dataclass
from faker import Faker


@dataclass
class InteractedUserModel:
    current_user_id: str
    interacted_user_id: str
    interacted_type: int
    update_at: datetime
    chat_channel_id: str
    is_fake_data: bool = True
    id: str = ""

    def to_dict(self):
        return {
            "id": self.id,
            "current_user_id": self.current_user_id,
            "interacted_user_id": self.interacted_user_id,
            "interacted_type": self.interacted_type,
            "update_at": self.update_at,
            "chat_channel_id": self.chat_channel_id,
            "is_fake_data": self.is_fake_data,
        }
    @classmethod
    def generateInteract(cls, current_user_id: str, interacted_user_id: str,):
        # fake data
        fake = Faker(locale="vi_VN")
        # create fake data, 1-5
        current_user_id = current_user_id
        interacted_user_id = interacted_user_id
        interacted_type = random.randint(1, 2)
        update_at = fake.future_date(end_date='+30d').strftime("%Y-%m-%d")
        interaction_id = current_user_id + '_' + interacted_user_id
        return InteractedUserModel(current_user_id, interacted_user_id,
                                   interacted_type, update_at, "", True, interaction_id)

    @staticmethod
    def from_json(json_data):
        return InteractedUserModel(
            current_user_id=json_data['current_user_id'],
            interacted_user_id=json_data['interacted_user_id'],
            interacted_type=json_data['interacted_type'],
            update_at=json_data['update_at'],
            chat_channel_id=json_data['chat_channel_id'],
            is_fake_data=json_data['is_fake_data'] if 'is_fake_data' in json_data else False,
            id=json_data['id'] if 'id' in json_data else "",
        )
