import math
import random
from datetime import datetime

import firebase_admin
import geopy.distance
import pandas as pd
from faker import Faker
from firebase_admin import firestore
from geopy import distance

from api.models.hobby_enum import Hobby
from api.models.photo_model import PhotoModel


def deg2rad(degrees):
    return degrees * math.pi / 180


def getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2):
    R = 6371
    dLat = deg2rad(lat2 - lat1)
    dLon = deg2rad(lon2 - lon1)
    a = math.sin(dLat / 2) * math.sin(dLat / 2) + math.cos(deg2rad(lat1)) \
        * math.cos(deg2rad(lat2)) * math.sin(dLon / 2) * math.sin(dLon / 2)
    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
    d = R * c
    return d


def generateAddress():
    # Read the Excel file
    df = pd.read_excel('mienbac.xlsx')
    # select a random row
    row = df.sample()
    #  return { address = city+ admin_name, lat , lng} using python
    address = row['city'].values[0] + ", " + row['admin_name'].values[0]
    lat = row['lat'].values[0]
    lng = row['lng'].values[0]
    return lat, lng, address


def genLocationFromSheet():
    lat, lng, address = generateAddress()
    return {
        'latitude': float(lat),
        'longitude': float(lng),
        'address': address,
        'create_at': datetime.now().isoformat(),
        'update_at': datetime.now().isoformat()
    }


def generateLocation(latitude, longitude, max_distance, min_distance=0):
    if min_distance > max_distance:
        raise ValueError(f"min_distance({min_distance}) cannot be greater than max_distance({max_distance})")

    # earth radius in km
    EARTH_RADIUS = 6371

    # 1° latitude in meters
    DEGREE = EARTH_RADIUS * 2 * math.pi / 360 * 1000

    # random distance within [min_distance-max_distance] in km in a non-uniform way
    max_km = max_distance * 1000
    min_km = min_distance * 1000
    r = ((max_km - min_km + 1) * random.random() ** 0.5) + min_km

    # random angle
    theta = random.random() * 2 * math.pi

    dy = r * math.sin(theta)
    dx = r * math.cos(theta)

    new_latitude = latitude + dy / DEGREE
    new_longitude = longitude + dx / (DEGREE * math.cos(deg2rad(latitude)))

    distance = round(getDistanceFromLatLonInKm(latitude, longitude, new_latitude, new_longitude))
    # address = getAddressFromLocation(latitude=new_latitude, longitude=new_longitude)
    # address = generateAddress()
    address = "Hà Nội"
    return {
        "newLatitude": new_latitude,
        "newLongitude": new_longitude,
        "distance": distance,
        "address": address
    }


def delete_docs_without_name_field(collection_name):
    # Initialize Firestore client
    firebase_admin.initialize_app()
    db = firestore.client()

    # Define a reference to the collection
    collection_ref = db.collection(collection_name)

    # Query for documents without a "name" field
    query = collection_ref.where("name", "==", None)

    # Delete each document in the query results
    for doc in query.stream():
        doc.reference.delete()


# print all docs in collection
def print_all_docs_in_collection(collection):
    docs = collection.stream()

    for doc in docs:
        print(f'{doc.id} => {doc.to_dict()}')


def nextIntOfDigits(digitCount):
    assert 1 <= digitCount <= 9
    min_num = 0 if digitCount == 1 else 10 ** (digitCount - 1)
    max_num = 10 ** digitCount
    return random.randint(min_num, max_num - 1)


# fake user
def fake_user():
    # fake data
    fake = Faker(locale="vi_VN")
    # create fake data
    id = fake.user_name()
    name = fake.name()
    email = fake.email()
    phone_number = '+84' + str(nextIntOfDigits(9))
    username = fake.user_name()
    gender = fake.random_int(min=0, max=1)
    birthday = fake.date_of_birth(minimum_age=18, maximum_age=30).strftime("%Y-%m-%d")
    avatar_url = fake.image_url()
    job = fake.job()
    # fake PhotoModel and add to list
    photo_list = [PhotoModel(id=0, url=fake.image_url(),
                             create_at=fake.date_time_between(start_date='-1y', end_date='now').isoformat()) for _ in
                  range(3)]
    description = fake.text(max_nb_chars=200)

    hobbies = [fake.random_element(elements=Hobby) for _ in range(nextIntOfDigits(1))]
    # convert hobbies to json
    hobbies2 = [hobby.toJSON() for hobby in hobbies]
    hobbies = [fake.random_element(elements=Hobby) for _ in range(10)]
    premium_expire_at = fake.future_date(end_date='+30d').strftime("%Y-%m-%d")
    local_gen = genLocationFromSheet()
    # hobby = Hobby.PHOTOGRAPHY
    # # get hobby index
    # hobby_index = Hobby.PHOTOGRAPHY.value
    # # get hobby name
    # print(Hobby.aslist())
    # print(Hobby.fromint(0))
    # print(hobby.name)
    # print(hobby.getId())

    # Create the user object
    user = {
        'id': id,
        'name': name,
        'email': email,
        'phone_number': phone_number,
        'username': username,
        'gender': gender,
        'birthday': birthday,
        'avatar_url': avatar_url,
        'job': job,
        'photo_list': photo_list,
        'description': description,
        'hobbies': hobbies,
        'premium_expire_at': premium_expire_at,
        'location': local_gen,
        'feed_filter': {
            'distance': fake.random_int(min=1, max=100),
            'interested_in_gender': fake.random_int(min=0, max=1),
            'age_range': {
                'start': fake.random_int(min=18, max=18),
                'end': fake.random_int(min=100, max=100)
            }
        },
        'online_flag': False,
        'is_fake_data': True,
    }
    return user


# input a_b
# output b_a
def get_reverse_id(id: str):
    return id.split('_')[1] + '_' + id.split('_')[0]


def print_user_info_from_user_ids(users_data, recommend_df, k=10):
    # Merge the dataframes
    merged_data = pd.merge(users_data, recommend_df[['id', 'hybrid_score']], on='id', how='left')

    # Fill NaN values with 0
    merged_data['hybrid_score'] = merged_data['hybrid_score'].fillna(0)
    # Sort the dataframe by hybrid_score
    merged_data.sort_values(by='hybrid_score', ascending=False, inplace=True)
    # Print the top k users
    # merged_data = merged_data[]
    return merged_data.head(k)


def distanceInKm(lat1, lon1, lat2, lon2):
    # approximate radius of earth in km
    coords_1 = (lat1, lon1)
    coords_2 = (lat2, lon2)
    return distance.great_circle(coords_1, coords_2).km


def getAddressFromLocation(latitude, longitude):
    return geopy.geocoders.Nominatim(
        user_agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36").reverse(
        (latitude, longitude)).address


def date_time_parser(value):
    if type(value) is str:
        return datetime.fromisoformat(value)
    return pd.to_datetime(value, unit='s')


import uuid
import time


def generate_transaction_id():
    #Alphanumeric[1,100]
    return str(uuid.uuid4())
