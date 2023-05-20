import string
from datetime import datetime
from typing import Dict

import firebase_admin
import pandas as pd
from firebase_admin import firestore
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

from api.models.user_score import UserScore
from utils import print_all_docs_in_collection


def get_user_index(user_id: string, user_item_matrix: pd.DataFrame):
    try:
        return int(user_item_matrix.index.build_loc(user_id))
    except Exception as e:
        print(e)
        return None


def build_recommendations(user_id, user_data, interaction_data):
    # Load data

    # user_data = pd.read_csv('user_data.csv')
    # interaction_data = pd.read_csv('interaction_data.csv')

    # Preprocess user data for content-based filtering
    tfidf = TfidfVectorizer(stop_words='english')
    user_data['text'] = user_data['interests'].fillna('')
    tfidf_matrix = tfidf.fit_transform(user_data['text'])
    interest_similarity_matrix = cosine_similarity(tfidf_matrix, tfidf_matrix)
    # Compute user-user similarity matrix for collaborative filtering
    # Left join because we will remove users who have not match filter
    print(interaction_data.head(5))
    print(user_data.head(5))
    merged_data = pd.merge(interaction_data, user_data, on='id')
    user_item_matrix = merged_data.pivot_table(index='id', columns='interacted_user_id', values='interact_type',
                                               fill_value=0)
    interaction_similarity_matrix = cosine_similarity(user_item_matrix)

    # hybrid_recommend = build_hybrid_recommend_users(user_id, interest_similarity_matrix, interaction_similarity_matrix,
    #                                                 user_item_matrix, user_data,
    #                                                 content_weight=0.6, threshold=0)
    # output = print_user_info_from_user_ids(user_data[['id', 'name']], hybrid_recommend,
    #                                        ).sort_values('hybrid_score', ascending=False)
    # return output


def compute_interest_similarity_scores(interest_similarity_df, user_id: str) -> Dict[str, float]:
    # Compute the similarity scores for a given user
    # get index of user_id in user_datas
    # interest_similarity_matrix set column name is user_id

    similarity_scores = {}
    for other_user_id, score in interest_similarity_df[user_id].items():
        if other_user_id != user_id:
            similarity_scores[other_user_id] = score
    return similarity_scores


def compute_interaction_scores(interaction_similarity_matrix, user_id: str) -> Dict[str, float]:
    # Compute the predicted scores for a given user
    interaction_scores = {}
    if user_id in interaction_similarity_matrix:
        for other_user_id, score in interaction_similarity_matrix[user_id].items():
            if other_user_id != user_id:
                interaction_scores[other_user_id] = score
    return interaction_scores


def compute_final_scores(interaction_similarity_df, interest_similarity_df,
                         user_id: str,
                         hobby_weight: float = 0.5) -> list[UserScore]:
    # Compute the final scores for a given user
    hobby_similarity_scores = compute_interest_similarity_scores(interest_similarity_df, user_id)
    interaction_similarity_scores = compute_interaction_scores(interaction_similarity_df, user_id)
    if not interaction_similarity_scores:
        # If interaction similarity scores are empty, increase hobby weight
        hobby_weight = 1
    if not hobby_similarity_scores:
        hobby_weight = 0
    final_scores = []
    now = datetime.now()
    if len(hobby_similarity_scores.keys())>0:
        for other_user_id in hobby_similarity_scores.keys():
            hobby_score = hobby_similarity_scores[other_user_id]
            interaction_score = interaction_similarity_scores.get(other_user_id, 0)
            final_score = hobby_weight * hobby_score + (1 - hobby_weight) * interaction_score
            final_scores.append(UserScore(user_id=other_user_id, score=final_score, create_at=now))
    else:
        for other_user_id in interaction_similarity_scores.keys():
            interaction_score = interaction_similarity_scores.get(other_user_id, 0)
            final_scores.append(UserScore(user_id=other_user_id, score=interaction_score, create_at=now))
    return final_scores


def build_similarity_data(user_data, interaction_data):
    # Preprocess user data for content-based filtering
    tfidf = TfidfVectorizer(stop_words='english')
    user_data['text'] = user_data['interests'].fillna('')
    tfidf_matrix = tfidf.fit_transform(user_data['text'])
    interest_similarity_matrix = cosine_similarity(tfidf_matrix)
    # set user id to col and row name
    interest_similarity_matrix = pd.DataFrame(interest_similarity_matrix, index=user_data['id'],
                                              columns=user_data['id'])

    user_item_matrix = interaction_data.pivot_table(index='id', columns='interacted_user_id', values='interact_type',
                                                    fill_value=0)
    interaction_similarity_matrix = cosine_similarity(user_item_matrix)
    # set user id to col and row name
    interaction_similarity_matrix = pd.DataFrame(interaction_similarity_matrix, index=user_item_matrix.index,
                                                 columns=user_item_matrix.index)

    # set similarity[index] = user id

    return interest_similarity_matrix, interaction_similarity_matrix


def _fetchAllUserData():
    firebase_admin.initialize_app()
    db = firestore.client()
    users_collection = db.collection("users")
    interactionsCollection = db.collection("interaction")
    # print users collections
    print_all_docs_in_collection(users_collection)
    return users_collection
