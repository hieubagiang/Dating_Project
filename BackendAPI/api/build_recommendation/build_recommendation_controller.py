from flask import Request
from pandas.io import json

import utils
from api import redis_client, db
from api.models.interacted_user_model import InteractedUserModel
from api.models.user_model import UserModel
from api.utils.utils import createPagination, limitDocs
from sample_hybird.build_score import *


# for delete empty name
# delete_docs_without_name_field("users")

def getUser(user_id):
    users_collection = db.collection("users")
    doc = users_collection.document(user_id).get()
    if doc.exists:
        if doc.to_dict()['is_anonymous_user']:
            return UserModel(
                id=doc.id,
                is_anonymous_user=True,
                is_fake_data=False,
            )
        return UserModel.from_json(doc.to_dict())
    else:
        return None


def build_scores(user_id: str=None):
    users_data, users_df, user_list = get_all_users()
    interactions_data, interactions_df = get_total_interaction()
    # print("Total users: " + str(len(users_data)))
    # print(users_df)
    # print(interactions_df)
    # print("Total interactions:  " + str(len(interactions_data)))
    # Build the scores collection for all users
    interest_similarity_df, interaction_similarity_df = build_similarity_data(users_df, interactions_df)
    # build all user score but too slow
    # for user in users_data:
    #     print("Building scores for user: " + user[0])
    #     print("Progress: " + str(users_data.index(user) + 1) + "/" + str(len(users_data)))
    #     final_scores = compute_final_scores(
    #         interest_similarity_df=interest_similarity_df,
    #         interaction_similarity_df=interaction_similarity_df,
    #         user_id=user[0])
    #     final_scores.sort(key=lambda x: x.score, reverse=True)
    #     scoreData = [score.to_dict() for score in final_scores]
    #     if user[0]==user_id:
    #         currentUserScore = scoreData
    #     redis_client.set('scores/'+user[0], json.dumps(scoreData), ex=10800)
    #     # save to redis
    #
    #     # create collection for user
    #     # convert to List of UserScore
    #     # Store the final scores for the user in Firestore
    if user_id is None:
        return
    print("Building scores for user: " + user_id)
    final_scores = compute_final_scores(
        interest_similarity_df=interest_similarity_df,
        interaction_similarity_df=interaction_similarity_df,
        user_id=user_id)
    final_scores.sort(key=lambda x: x.score, reverse=True)
    scoreData = [score.to_dict() for score in final_scores]
    redis_client.set('scores/' + user_id, json.dumps(scoreData), ex=10800)
    return scoreData


def get_total_interaction():
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


def get_all_users():
    global tmp_user
    try:

        users_collection = db.collection("users")
        docs = users_collection.get()
        user_list = []
        users_with_hobby_data = []
        for doc in docs:
            if 'name' not in doc.to_dict():
                continue
            if doc.to_dict()['is_anonymous_user']:
                users_with_hobby_data.append([doc.id, ''])
                user_list.append(UserModel(id=doc.id, is_anonymous_user=True, is_fake_data=False))
                continue
            tmp_user = UserModel.from_json(doc.to_dict())
            hobbies_list = []
            for hobby in tmp_user.hobbies:
                hobbies_list.append(hobby.name)
            hobbies = ",".join(hobbies_list)
            users_with_hobby_data.append([tmp_user.id, hobbies])
            user_list.append(tmp_user)
        users_df = pd.DataFrame(users_with_hobby_data, columns=['id', 'interests'])
        print(users_df[users_df.duplicated(subset='id', keep=False)])

        return users_with_hobby_data, users_df, user_list
    except Exception as e:
        print(e)
        print("Error on user", tmp_user.id)
        print("Error on getUserWithFilter")



# def getRecommend(user_id):
# recommend = get_recommendations(user_id, users_df, interactions_df)
# df = recommend[recommend['id'] != current_user.id]
# df = df[['id', 'hybrid_score']]
# usersFullInfo = pd.DataFrame.from_records([u.__dict__ for u in userList])
# final = pd.merge(df, usersFullInfo, on='id')
# return final

def get_recommendation_for_guest(user_id: str, page: int, limit: int):
    # check last doc from redis if page != 1
    users_ref = db.collection('users').where('name', '!=', '').order_by('name').order_by('create_at', 'DESCENDING')
    # Get total number of documents
    users_snapshot = users_ref.offset((page - 1) * limit).limit(limit).get()
    filtered_users = []
    for user in users_snapshot:
        user_model = UserModel.from_json(user.to_dict())
        if user_model.id == user_id or user_model.is_anonymous_user:
            continue
        filtered_users.append(user_model)
    return filtered_users, createPagination(len(users_ref.get()), page, limit)


def filter_users(user_id: str, all_users: list[UserModel], except_users: list[str]):
    # lấy doc của user đang đăng nhập
    current_user = getUser(user_id)
    feed_filter = current_user.feed_filter
    filtered_users = []
    for tmp_user_model in all_users:
        # Lọc bỏ user đang đăng nhập và các user đã tương tác
        if tmp_user_model.id in except_users:
            continue
        if tmp_user_model.id != user_id:
            # Lấy thông tin độ tuổi và giới tính của user
            if str(tmp_user_model.username) == 'nan' or tmp_user_model.is_anonymous_user:
                db.collection('users')\
                    .document(tmp_user_model.id)\
                    .get().reference.update({"is_anonymous_user": True})
                continue
            user_age = tmp_user_model.getAge()
            if tmp_user_model.gender != feed_filter.get_interested_in_gender():
                continue
            # nếu user không phù hợp với yêu cầu về độ tuổi
            if user_age <= feed_filter.age_range.start or user_age >= feed_filter.age_range.end:
                continue
            # nếu user không phù hợp với yêu cầu về khoảng cách
            if utils.distanceInKm(lat1=tmp_user_model.location.latitude,
                                  lon1=tmp_user_model.location.longitude, lat2=current_user.location.latitude,
                                  lon2=current_user.location.longitude
                                  ) > feed_filter.distance:
                continue

            filtered_users.append(tmp_user_model)
    return filtered_users


def get_interacted_users(user_id):
    interacted_users = []
    try:
        interactions_ref = db.collection('interaction')
        interactions = interactions_ref.where('current_user_id', '==', user_id).stream()
        for interaction in interactions:
            tmp_interaction = InteractedUserModel.from_json(interaction.to_dict())
            # condition for check interacted type
            if tmp_interaction.interacted_type == 1 or tmp_interaction.interacted_type == 2 \
                    or tmp_interaction.interacted_type == 3 or tmp_interaction.interacted_type == 4:
                interacted_users.append(tmp_interaction.interacted_user_id)
    except Exception as e:
        print(e)
        print("Error on getInteractedUsers".format(e))
    return interacted_users


def build_except_users(user_id):
    #Bỏ qua user hiện tại
    except_users = [user_id]
    #Bỏ qua các user đã tương tác
    interacted_users = get_interacted_users(user_id)
    except_users.extend(interacted_users)
    return except_users


def get_recommendation(request: Request):
    # get user id from @require_authenticate
    user_id = request.user_id
    # Get page and limit from query parameters
    page = request.args.get('page', default=1, type=int)
    limit = request.args.get('limit', default=10, type=int)
    # Get recommendations for user_id based on page and limit
    current_user = getUser(user_id)
    if current_user.is_anonymous_user:
        return return_recommend_for_guest(current_user, limit, page)

    else:
        # check redis cache
        recommended_user_list = get_recomendation_from_redis_cache(user_id) if page >0   else None
        if recommended_user_list is None:
            # scores = getRedisScore(user_id, force=page ==1)
            scores = get_scores_data_of_user(user_id)
            # query all user in firestore collections
            recommended_user_list = get_all_user(recommended_user_list)
            # merge scores and user data
            recommended_user_list = recommended_user_from_marchine_learning(recommended_user_list, scores)
            extend_result_if_needed(current_user, limit, page, recommended_user_list)
            recommended_user_list = remove_users_not_match_filter(current_user, page, recommended_user_list, user_id)
            # save to redis
            recommended_user_list = cache_result_to_redis(recommended_user_list, user_id)
        return return_result(limit, page, recommended_user_list)


def return_result(limit, page, recommended_user_list):
    # Paginate the results
    recommends, pagination = limitDocs(recommended_user_list, page, limit)
    return {'data': recommends, 'pagination': pagination}


def return_recommend_for_guest(current_user, limit, page):
    recommended_user_list, pagination = get_recommendation_for_guest(current_user.id, page, limit)
    recommends = [user.to_dict() for user in recommended_user_list]
    return {'data': recommends, 'pagination': pagination}


def cache_result_to_redis(recommended_user_list, user_id):
    recommended_user_list = [user.to_dict() for user in recommended_user_list]
    redis_client.set('recommendations/{}'.format(user_id), json.dumps(recommended_user_list, ensure_ascii=False),
                     ex=300)
    return recommended_user_list


def remove_users_not_match_filter(current_user, page, recommended_user_list, user_id):
    if not current_user.is_anonymous_user:
        except_users = build_except_users(user_id)
        # except_users = []
        recommended_user_list = filter_users(user_id, recommended_user_list, except_users)
    return recommended_user_list


def extend_result_if_needed(current_user, limit, page, recommended_user_list):
    add_all_user_list = []
    if len(recommended_user_list) < 11:
        add_all_user_list, pagination = get_recommendation_for_guest(current_user.id, page, limit)
    recommended_user_list.extend(add_all_user_list)


def recommended_user_from_marchine_learning(recommended_user_list, scores):
    all_user_df = pd.DataFrame.from_records(recommended_user_list, index='id')
    scores_df = pd.DataFrame.from_records(scores, index='user_id')
    # merge 2 dataframe to get score for each user
    all_user_df = scores_df.merge(all_user_df, left_index=True, right_index=True)
    all_user_df['id'] = all_user_df.index
    recommended_user_list = [UserModel.from_json(user) for user in all_user_df.to_dict(orient='records')]
    return recommended_user_list


def get_all_user(recommended_user_list):
    users_collection = db.collection('users')
    all_users = users_collection.where('name', '!=', 'NULL').stream()
    recommended_user_list = [user.to_dict() for user in all_users]
    return recommended_user_list


def get_scores_data_of_user(user_id, force=False):
    print('get score cached from redis')
    score = redis_client.get('scores/' + user_id)
    if score is None or len(json.loads(score)) or force:
        print("scores is None, building score data")
        return build_scores(user_id)
        # return getRedisScore(user_id)
    print("scores cached for this user" + user_id)
    score = json.loads(score)
    return score


def get_recomendation_from_redis_cache(user_id):
    cache_key = 'recommendations/{}'.format(user_id)
    if redis_client.exists(cache_key):
        print("redis_client.exists(cache_key)")
        data = json.loads(redis_client.get(cache_key))
        return data
    return None

# output = createGetRecommendAPI("2HVD1ihazFXYJTmXKccNLMa5mWs1")
# print(output)
# build_scores_collection('2HVD1ihazFXYJTmXKccNLMa5mWs1')
# getRedisScore('2HVD1ihazFXYJTmXKccNLMa5mWs1')
# getRedisRecomendation('2HVD1ihazFXYJTmXKccNLMa5mWs1')
# res= getRecommendation("2HVD1ihazFXYJTmXKccNLMa5mW s1", 1, 10)
# print('res', res)
# if __name__ == "__main__":
#     asyncio.run(main())

# exit(0)
