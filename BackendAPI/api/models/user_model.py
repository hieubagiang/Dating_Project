import json
from datetime import datetime, timedelta
from enum import Enum
from types import NoneType

import dateutil.parser as parser
from faker import Faker

from admin_tools.fake_user.fake_name import create_name_with_gender
from api.models.age_range import AgeRangeModel
from api.models.feed_filter_model import FeedFilterModel
from api.models.hobby_enum import Hobby
from api.models.hobby_model import HobbyModel
from api.models.photo_model import PhotoModel
from api.models.position_model import PositionModel
from api.utils.utils import date_to_datetime
from utils import date_time_parser, nextIntOfDigits, genLocationFromSheet


class UserModelEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, NoneType):
            return obj.__dict__
        if isinstance(obj, Enum):
            return obj.value
        elif isinstance(obj, datetime):
            return obj.isoformat()
        elif isinstance(obj, UserModel):
            return obj.__dict__
        elif isinstance(obj, FeedFilterModel):
            return obj.__dict__
        elif isinstance(obj, PhotoModel):
            return obj.__dict__
        elif isinstance(obj, HobbyModel):
            return obj.__dict__
        elif isinstance(obj, PositionModel):
            return obj.__dict__
        elif isinstance(obj, AgeRangeModel):
            return obj.__dict__
        else:
            return json.JSONEncoder.default(self, obj)


class UserModel:
    def __init__(self, id: str=None, name: str=None, phone_number: str=None, email: str=None, username: str=None, gender: str=None,
                 birthday: datetime=None, avatar_url: str=None, job: str=None, photo_list: list[PhotoModel]=None, description: str=None,
                 hobbies: list[HobbyModel]=None, premium_expire_at: datetime=None, location: PositionModel=None,
                 feed_filter: FeedFilterModel=None, online_flag: bool=None, last_online: datetime=None, create_at: datetime=None,
                 update_at: datetime=None, token: str=None, is_fake_data: bool=None, is_anonymous_user: bool=None):
        self.id = id
        self.name = name
        self.phone_number = phone_number
        self.email = email
        self.username = username
        self.gender = gender
        self.birthday = birthday
        self.avatar_url = avatar_url
        self.job = job
        self.photo_list = photo_list
        self.description = description
        self.hobbies = hobbies
        self.premium_expire_at = premium_expire_at
        self.location = location
        self.feed_filter = feed_filter
        self.online_flag = online_flag
        self.last_online = last_online
        self.create_at = create_at
        self.update_at = update_at
        self.token = token,
        self.is_fake_data = is_fake_data
        self.is_anonymous_user = is_anonymous_user

    def getHobbiesText(self):
        hobbiesList = []
        for hobby in self.hobbies:
            hobbiesList.append(hobby.name)
        hobbies = ",".join(hobbiesList)
        return hobbies

    def getAge(self):
        return datetime.now().year - self.birthday.year

    def addPremium(self, add_day: int):
        current_expiry = self.premium_expire_at or datetime.now()

        if current_expiry < datetime.now():
            current_expiry = datetime.now()

        new_expiry = current_expiry + timedelta(days=add_day)
        self.premium_expire_at = new_expiry
        self.update_at = datetime.now()

    @staticmethod
    def from_json(json_data):
        id = json_data.get('id')
        name = json_data.get('name')
        phone_number = str(json_data.get('job')) if str(json_data.get('phone_number'))!= 'nan' else None
        email = json_data.get('email')
        username = json_data.get('username')
        gender = json_data.get('gender')
        birthday = parser.parse(str(json_data.get('birthday'))) if str(json_data.get('birthday'))!= 'nan' else None
        avatar_url = json_data.get('avatar_url')
        job = str(json_data.get('job')) if str(json_data.get('job'))!= 'nan'  else None
        photo_list = []

        if 'photo_list' in json_data and json_data['photo_list'] is not None:
            for photo in json_data['photo_list']:
                photo_list.append(PhotoModel.from_json(photo))
        description = json_data.get('description')
        hobbies = []
        if 'hobbies' in json_data:
            for hobby in json_data['hobbies']:
                hobbies.append(HobbyModel.from_json(hobby))
        premium_expire_at = parser.parse(
            json_data.get('premium_expire_at')) if 'premium_expire_at' in json_data else None
        location = None
        if 'location' in json_data and json_data['location'] is not None:
            location = PositionModel.from_json(json_data['location'])
        feed_filter = None
        if 'feed_filter' in json_data and json_data['feed_filter'] is not None:
            feed_filter = FeedFilterModel.from_json(json_data['feed_filter'])
        online_flag = json_data.get('online_flag')
        last_online = None
        if 'lastOnline' in json_data and json_data['lastOnline'] is not None:
            last_online = date_time_parser(json_data.get('lastOnline'))
        create_at = None
        if 'create_at' in json_data and json_data['create_at'] is not None:
            create_at = date_time_parser(json_data.get('create_at'))

        update_at = None
        if 'update_at' in json_data and json_data['update_at'] is not None:
            update_at = date_time_parser(json_data.get('update_at'))
        token = json_data.get('token') if 'token' in json_data else None
        is_fake_data = json_data.get('is_fake_data') if 'is_fake_data' in json_data else False
        is_anonymous_user = json_data.get('is_anonymous_user') if 'is_anonymous_user' in json_data else False
        return UserModel(id, name, phone_number, email, username, gender, birthday, avatar_url, job, photo_list,
                         description, hobbies, premium_expire_at, location, feed_filter, online_flag, last_online,
                         create_at, update_at, token, is_fake_data, is_anonymous_user)
    def to_json(self):
        json.dumps(self, cls=UserModelEncoder)
    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "phone_number": self.phone_number,
            "email": self.email,
            "username": self.username,
            "gender": self.gender,
            "birthday": self.birthday.isoformat() if self.birthday is not None else None,
            "avatar_url": self.avatar_url,
            "job": self.job if str(self.job) != 'nan' else None,
            "photo_list": [photo.to_dict() for photo in self.photo_list],
            "description": self.description,
            "hobbies": [hobby.to_dict() for hobby in self.hobbies],
            "premium_expire_at": self.premium_expire_at.isoformat() if self.premium_expire_at is not None else None,
            "location": self.location.to_dict() if self.location is not None else None,
            "feed_filter": self.feed_filter.to_dict(),
            "online_flag": self.online_flag,
            "last_online": self.last_online.isoformat() if self.last_online is not None else None,
            "create_at": self.create_at.isoformat() if self.create_at is not None else None,
            "update_at": self.update_at.isoformat() if self.update_at is not None else None,
            # "token": self.token if self.token is not None else None
            "is_fake_data": self.is_fake_data,
            "is_anonymous_user": self.is_anonymous_user
        }

    def __str__(self):
        return self.to_dict()

    @staticmethod
    def create_fake_data():
        # use Faker
        fake = Faker(locale="vi_VN")
        # create fake data
        gender = fake.random_int(min=1, max=2)
        name = create_name_with_gender(gender == 1)
        email = fake.email()
        phone_number = '+84' + str(nextIntOfDigits(9))
        username = fake.user_name()
        id = username
        birthday = date_to_datetime(fake.date_of_birth(minimum_age=18, maximum_age=40))
        avatar_url = fake.image_url()
        job = fake.job()
        photo_list = [PhotoModel(photo_id=i, url=fake.image_url(),
                                 create_at=fake.date_time_between(start_date='-1y', end_date='now'),
                                 update_at=fake.date_time_between(start_date='-1y', end_date='now'),
                                 ) for i in range(1,4)]
        description = fake.text(max_nb_chars=200)

        hobbies = [HobbyModel.from_json(fake.random_element(elements=Hobby).toJSON()) for _ in range(10)]
        premium_expire_at = date_to_datetime(fake.future_date(end_date='+30d'))
        local_gen = genLocationFromSheet()

        user_model = UserModel(
            id=id,
            name=name,
            phone_number=phone_number,
            email=email,
            username=username,
            gender='male' if gender==1 else'female',
            birthday=birthday,
            avatar_url=avatar_url,
            job=job,
            photo_list=photo_list,
            description=description,
            hobbies=hobbies,
            premium_expire_at=premium_expire_at,
            location=PositionModel.from_json(local_gen),
            feed_filter=FeedFilterModel.from_json({
                'distance': fake.random_int(min=100, max=1000),
                'interested_in_gender': fake.random_int(min=1, max=2),
                'age_range': {
                    'start': fake.random_int(min=18, max=18),
                    'end': fake.random_int(min=100, max=100)
                },
                'create_at': date_to_datetime(fake.date_time_between(start_date='-1y', end_date='now')).isoformat(),
            }),
            online_flag=False,
            last_online=date_to_datetime(fake.date_time_between(start_date='-1y', end_date='now')),
            create_at=date_to_datetime(fake.date_time_between(start_date='-1y', end_date='now')),
            update_at=date_to_datetime(fake.date_time_between(start_date='-1y', end_date='now')),
            token='',
            is_fake_data=True,
            is_anonymous_user=False
        )
        return user_model

