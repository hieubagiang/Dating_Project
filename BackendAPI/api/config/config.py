import os
import time
from os.path import dirname, join
import pytz
import datetime

import firebase_admin
import redis
from firebase_admin import credentials, firestore
from flask import Blueprint

project_root = dirname(dirname(__file__))
output_path = join(project_root, 'config/serviceAccountKey.json')

cred = credentials.Certificate(output_path)
firebase_admin.initialize_app(cred)
REDIS_HOST = 'hieuit.top'
REDIS_PORT = 6379
REDIS_DB = 0
REDIS_PASS = 'XXXXXX'#Em xin phép xoá các thông tin private để đảm bảo an toàn cho server
redis_client = redis.Redis(host=REDIS_HOST, port=REDIS_PORT, db=REDIS_DB,password=REDIS_PASS)
api_app = Blueprint('api', __name__)
db = firestore.client()

headers = {
    'Authorization': 'key=XXXXXX',#Em xin phép xoá các thông tin private để đảm bảo an toàn cho server
    'Content-Type': 'application/json'
}
# Set the desired time zone
desired_timezone = 'Asia/Ho_Chi_Minh'
pytz.timezone(desired_timezone)
