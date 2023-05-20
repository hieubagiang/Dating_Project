import json
import random
from datetime import datetime

from faker import Faker
from firebase_admin import firestore

import utils
from api.models.interacted_user_model import InteractedUserModel
# cred = credentials.Certificate('serviceAccountKey.json')
# firebase_admin.initialize_app(cred)
from api.models.photo_model import PhotoModel
from api.models.user_model import UserModel

db = firestore.client()
# for delete empty name
# delete_docs_without_name_field("users")
users_collection = db.collection("users")
interactionsCollection = db.collection("interaction")


def createFakeUser(size: int = 20):
    for i in range(size):
        print("processing: " + str(i) + "/" + str(size))
        tmp_user = UserModel.create_fake_data()
        print("create user: " + tmp_user.username)

        doc_ref = users_collection.document(tmp_user.username)
        doc_ref.set(tmp_user.to_dict())


# print users collections
# utils.print_all_docs_in_collection(users_collection)
# create fake user
# createFakeUser(200)


def deleteFakeUser():
    fake_user_docs = users_collection.stream()
    for docTmp in fake_user_docs:
        if docTmp.to_dict()['is_fake_data'] or ('name' in docTmp.to_dict() and docTmp.to_dict()['name'] == docTmp.id):
            print("delete user: " + docTmp.id)
            docTmp.reference.delete()


def deleteFakeInteraction(count: int = 20):
    fake_interactions = interactionsCollection.where("is_fake_data", "==", True).stream()
    for itr in fake_interactions:
        itr.reference.delete()


def fakeInteraction():
    fake_user_docs = users_collection.where("is_fake_data", "==", True).stream()
    # create array
    user_ids = []
    for doc in fake_user_docs:
        user_ids.append(doc.id, )
    print(len(user_ids))
    fake_user_docs = users_collection.where("is_fake_data", "==", True).stream()
    for doc in fake_user_docs:
        for i in range(20):
            tmp = InteractedUserModel.generateInteract(doc.id, user_ids[random.randint(0, len(user_ids) - 1)])
            doc_ref = interactionsCollection.document(tmp.id)
            doc_ref.set(tmp.to_dict())
            # print(tmp.to_dict())


def fakeMatch():
    interactions_fake = interactionsCollection.where("is_fake_data", "==", True).stream()
    for doc in interactions_fake:
        if doc.to_dict()['interacted_type'] == 2:
            # get reverse interaction
            reverse_interaction = interactionsCollection.document(utils.get_reverse_id(doc.id)).get()
            if reverse_interaction.exists and reverse_interaction.to_dict()['interacted_type'] == 2:
                print(reverse_interaction.to_dict())
                print(doc.to_dict())
                print(doc.id)
                print(reverse_interaction.id)
                print("=====================================")
                # update both interaction to 3
                doc.reference.update({"interacted_type": 3})
                reverse_interaction.reference.update({"interacted_type": 3})


# fakeInteraction()
#
# for i in range(20):
#     tmp_user = utils.fake_user()
#     print(tmp_user)
def fixAnyCustom():
    #select ref users collection and id = 8RKQ9te1GDPcrk9OBRFr7XAP9Sq2
    # user = users_collection.document("MGaw1sz7gtb6mUiCC7gDE1NrHlA2").get().reference.update({"is_anonymous_user": True})
    #change value of field is_fake_data to false
    # users = users_collection.stream()
    # for user in users:
    #     print(user.id)
    #     if 'username' in user.to_dict() and str(user.to_dict()['username'])== 'nan':
    #         user.reference.update({"is_anonymous_user": True})
    #     else:
    #         user.reference.update({"is_anonymous_user": False})

    #fix user name
    # for user in users:
    #     userData= user.to_dict()
    #     print(user.id)
    #     if 'username' in userData and user.id == userData['username'] and userData['username'] != userData['id']:
    #         user.reference.update({"id": user.id})
    users_collection.document('8UFRXuWapzXMfnGaR9Kfn9K3vZo1').update({"username":'gialong', "name":'Gia Long'})
def fixUserId():
    users = users_collection.stream()
    for user in users:
        if not user.to_dict()['is_fake_data']:
            if 'name' in user.to_dict() and user.id == user.to_dict()['username']:
                user.reference.update({"is_fake_data": True})
            # user.reference.update({"username": new_username})


def fixLocation():
    users = users_collection.stream()
    for user in users:
        # check is fake data
        if 'is_fake_data' not in user.to_dict().keys():
            user.reference.update({"is_fake_data": False})
            continue
        if user.to_dict()['is_fake_data']:
            print(user.to_dict()['location'])
            new_location = utils.genLocationFromSheet()
            print(new_location)
            user.reference.update({"location": new_location})
        else:
            new_location = utils.genLocationFromSheet()
            user.reference.update({"location": new_location})


def fixFeedFilter():
    user = users_collection.document("2HVD1ihazFXYJTmXKccNLMa5mWs1")

    user.update({'feed_filter': {
        'distance': 10000,
        'interested_in_gender': 2,
        'age_range': {
            'start': 16,
            'end': 100
        }
    }, "location": {
        'address': 'Phùng Khoang, Trung Văn, Nam Từ Liêm, Hà Nội, Việt Nam',
        'latitude': 20.9886821,
        'longitude': 105.7904415,
        'create_at': datetime.now().isoformat(),
        'update_at': datetime.now().isoformat()
    }})
    print(user.get().to_dict())


def addUserId():
    users = users_collection.stream()
    for user in users:
        if 'id' not in user.to_dict().keys():
            user.reference.update({"id": user.id})


def fixGender():
    users = users_collection.stream()
    for user in users:
        # print progress
        print(user.id)
        # check is fake data
        if ('is_fake_data' not in user.to_dict().keys()):
            current_gender = user.to_dict().get('gender')  # return value = 1 or 2
            current_gender = 'male' if current_gender == 1 else 'female'
            user.reference.update({"gender": current_gender})
            continue
        if user.to_dict()['is_fake_data']:
            current_gender = user.to_dict().get('gender')  # return value = 0 or 1
            current_gender = 'male' if current_gender == 0 else 'female'
            user.reference.update({"gender": current_gender})
            # user.reference.update({"location": new_location})
        else:
            current_gender = user.to_dict().get('gender')  # return value = 1 or 2
            current_gender = 'male' if current_gender == 1 else 'female'
            user.reference.update({"gender": current_gender})


def fixGender():
    users = users_collection.stream()
    for user in users:
        # print progress
        print(user.id)
        # check is fake data
        if ('is_fake_data' not in user.to_dict().keys()):
            current_gender = user.to_dict().get('gender')  # return value = 1 or 2
            current_gender = 'male' if current_gender == 1 else 'female'
            user.reference.update({"gender": current_gender})
            continue
        if user.to_dict()['is_fake_data']:
            current_gender = user.to_dict().get('gender')  # return value = 0 or 1
            current_gender = 'male' if current_gender == 0 else 'female'
            user.reference.update({"gender": current_gender})
            # user.reference.update({"location": new_location})
        else:
            current_gender = user.to_dict().get('gender')  # return value = 1 or 2
            current_gender = 'male' if current_gender == 1 else 'female'
            user.reference.update({"gender": current_gender})


# fixLocation()

# fixFeedFilter()

#deleteFakeUser()
# deleteFakeInteraction()
#fixUserId()
# addUserId()
# createFakeUser(50)
# fakeInteraction()
#createFakeUser(200)
# fixGender()
fixAnyCustom()
exit(0)
