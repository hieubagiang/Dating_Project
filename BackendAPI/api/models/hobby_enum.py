from enum import Enum


class Hobby(Enum):
    PHOTOGRAPHY = (1, 'photography')
    SHOPPING = (2, 'shopping')
    KARAOKE = (3, 'karaoke')
    YOGA = (4, 'yoga')
    COOKING = (5, 'cooking')
    TENNIS = (6, 'tennis')
    RUN = (7, 'run')
    SWIMMING = (8, 'swimming')
    ART = (9, 'art')
    TRAVELLING = (10, 'travelling')
    EXTREME = (11, 'extreme')
    MUSIC = (12, 'music')
    DRINK = (13, 'drink')
    VIDEO_GAMES = (14, 'video_games')

    def getId(self):
        return self.value[0]

    def getName(self):
        return self.value[1]

    def toJSON(self):
        return {
            'id': self.getId(),
            'name': self.getName()
        }

    @classmethod
    def aslist(cls):
        return list(map(lambda c: c.value, cls))

    @classmethod
    def fromint(cls, index):
        return cls.aslist()[index-1]

    @staticmethod
    def from_json(json_data):
        return Hobby.fromint(json_data['id'])
