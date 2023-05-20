from datetime import datetime

import pandas as pd
from firebase_admin import firestore
from pandas.io import json

import utils
from api.exceptions.exception import ApiException
from api.models.interacted_user_model import InteractedUserModel
from api.models.user_model import UserModel
from sample_hybird.hybrid import get_recommendations

db = firestore.client()


# for delete empty name
# delete_docs_without_name_field("users")

def getUser(user_id):
    users_collection = db.collection("users")
    doc = users_collection.document(user_id).get()
    if doc.exists:
        return UserModel.from_json(doc.to_dict())
    else:
        return None


def getRecommend(user_id):
    # get current user information
    current_user = getUser(user_id)
    if current_user is None:
        raise ApiException(status=False, error_message="User not found")

    feed_filter = current_user.feed_filter
    # print(json.dumps(current_user))
    users_data, users_df, userList = getUserWithFilter(current_user, feed_filter)
    interactions_data, interactions_df = getTotalInteraction()
    # print("Total users: " + str(len(users_data)))
    # print(users_df)
    # print(interactions_df)
    # print("Total interactions: " + str(len(interactions_data)))
    recommend = get_recommendations(user_id, users_df, interactions_df)
    df = recommend[recommend['id'] != current_user.id]
    df = df[['id', 'hybrid_score']]
    usersFullInfo = pd.DataFrame.from_records([u.__dict__ for u in userList])
    final = pd.merge(df, usersFullInfo, on='id')
    return final


def getTotalInteraction():
    interactions_data = None
    interactions_df = None
    try:
        interactions_ref = db.collection('interaction')
        interactions = interactions_ref.get()
        interactions_data = []
        for interaction in interactions:
            tmpInteraction = InteractedUserModel.from_json(interaction.to_dict())
            interactPoint = 1 if tmpInteraction.interacted_type == 0 or tmpInteraction.interacted_type == 5 else 2
            interactions_data.append([tmpInteraction.current_user_id, tmpInteraction.interacted_user_id, interactPoint])
        interactions_df = pd.DataFrame(interactions_data, columns=['id', 'interacted_user_id', 'interact_type'])
    except Exception as e:
        print(e)
        print("Error on getTotalInteraction".format(e))
    return interactions_data, interactions_df


def getUserWithFilter(current_user, feed_filter):
    global tmp_user
    try:
        users_collection = db.collection("users")
        docs = users_collection.get()
        # docs = users_collection \
        #     .where(field_path='gender', op_string='==', value=feed_filter.interested_in_gender).get()
        user_list = []
        # filter docs by age range
        for doc in docs:
            if 'id' not in doc.to_dict() or 'name' not in doc.to_dict():
                continue
            try:
                tmp_user = UserModel.from_json(doc.to_dict())
            except Exception as e:
                print(e)
                print("Error on getUserWithFilter".format(e))
            if tmp_user.birthday is not None:
                age = datetime.now().year - tmp_user.birthday.year
                if age < feed_filter.age_range.start or age > feed_filter.age_range.end:
                    docs.remove(doc)
            # filter docs by distance
            if tmp_user.location is not None:
                distance = utils.distanceInKm(lat1=tmp_user.location.latitude, lon1=tmp_user.location.longitude,
                                              lat2=current_user.location.latitude, lon2=current_user.location.longitude)
                if distance > feed_filter.distance:
                    docs.remove(doc)
        # users_data = [[current_user.id, current_user.name, current_user.birthday, current_user.getHobbiesText()]]
        users_data = []
        for doc in docs:
            if 'name' not in doc.to_dict():
                continue
            tmp_user = UserModel.from_json(doc.to_dict())
            # tmp_user.hobbies.value join with , to string
            hobbiesList = []
            for hobby in tmp_user.hobbies:
                hobbiesList.append(hobby.name)
            hobbies = ",".join(hobbiesList)
            users_data.append([tmp_user.id, tmp_user.name, tmp_user.birthday, hobbies])
            user_list.append(tmp_user)

        # print user data
        # for current_user in users_data:
        #     if current_user[0] == user_id:
        #         print('found')
        #     print(json.dumps(current_user))
        users_df = pd.DataFrame(users_data, columns=['id', 'name', 'age', 'interests'])
        return users_data, users_df, user_list
    except Exception as e:
        print(e)
        print("Error on getUserWithFilter".format(e))


def createPagination(total, page, limit):
    pagination = {'total': total, 'page': page, 'limit': limit}
    return pagination


def limitDocs(docs, page, limit):
    start = (page - 1) * limit
    end = start + limit
    # return error if page is out of range
    return docs[start:end], createPagination(len(docs), page, limit)


def createGetRecommendAPI(user_id, page=1, limit=10):
    recommends = getRecommend(user_id)
    # out of range
    if (page - 1) * limit > len(recommends):
        raise ApiException(status=False, error_message="Page out of range")
    recommends, pagination = limitDocs(recommends, page, limit)
    print(recommends.head(5).to_string())
    dataOutput = recommends.to_json(orient='records')
    # create output is json string with {data: [], pagination: {}} format
    return {'data': json.loads(dataOutput), 'pagination': pagination}

# output = createGetRecommendAPI("2HVD1ihazFXYJTmXKccNLMa5mWs1")
# print(output)
