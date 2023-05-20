import string

import firebase_admin
import pandas as pd
from firebase_admin import firestore
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

from utils import print_user_info_from_user_ids, print_all_docs_in_collection


def get_user_index(user_id: string, user_item_matrix: pd.DataFrame):
    try:
        return int(user_item_matrix.index.get_loc(user_id))
    except Exception as e:
        print(e)
        return None

def get_user_ids(user_indices, user_item_matrix):
    user_ids = []
    for index in user_indices:
        user_id = user_item_matrix.index[index]
        user_ids.append(user_id)
    return user_ids


def get_content_based_recommend_users(user_id, cosine_sim, user_item_matrix, user_data):
    try:
        user_index = get_user_index(user_id, user_item_matrix)
        print(type(user_index))
        similarity_scores = list(enumerate(cosine_sim[user_index]))
        similarity_scores = sorted(similarity_scores, key=lambda x: x[1], reverse=True)
        similarity_scores = similarity_scores[1:]
        user_indices = [i[0] for i in similarity_scores]
        user_scores = [i[1] for i in similarity_scores]
        result_df = user_data[['id']].iloc[user_indices].copy()
        result_df['similarity_score'] = user_scores
        return result_df
    except Exception as e:
        print(e)
        return None


def get_collaborative_filter_recommend_users(user_id, interaction_similarity_matrix, user_item_matrix, user_data):
    # Get similarity scores for the given user
    user_index = get_user_index(user_id, user_item_matrix)
    print(type(user_index))

    similarity_scores = list(enumerate(interaction_similarity_matrix[user_index]))

    # Sort the similarity scores in descending order
    similarity_scores = sorted(similarity_scores, key=lambda x: x[1], reverse=True)

    similarity_scores = similarity_scores[1:]
    user_indices = [i[0] for i in similarity_scores]
    user_scores = [i[1] for i in similarity_scores]
    result_df = user_data[['id']].iloc[user_indices].copy()
    result_df['similarity_score'] = user_scores
    return result_df


def get_hybrid_recommend_users(user_id, interest_similarity_matrix, interaction_similarity_matrix, user_item_matrix,
                               user_data, content_weight,
                               threshold):
    # Get content-based recommendations
    content_based = get_content_based_recommend_users(user_id=user_id, cosine_sim=interest_similarity_matrix,
                                                      user_item_matrix=user_item_matrix, user_data=user_data)
    # Get collaborative filtering recommendations
    collaborative_filter = get_collaborative_filter_recommend_users(user_id=user_id,
                                                                    interaction_similarity_matrix=interaction_similarity_matrix,
                                                                    user_item_matrix=user_item_matrix,
                                                                    user_data=user_data)

    # Merge the two dataframes
    merged_df = pd.merge(content_based, collaborative_filter, on='id', how='outer',
                         suffixes=('_content', '_collaborative'))

    # Fill missing values with 0
    merged_df = merged_df.fillna(0)

    # Calculate the hybrid score
    merged_df['hybrid_score'] = (content_weight * merged_df['similarity_score_content']) + (
            (1 - content_weight) * merged_df['similarity_score_collaborative'])

    # Filter recommendations based on threshold
    merged_df = merged_df[merged_df['hybrid_score'] >= threshold]

    # Sort by hybrid score in descending order
    merged_df = merged_df.sort_values('hybrid_score', ascending=False)

    return merged_df[['id', 'hybrid_score']]


def get_recommendations(user_id, user_data, interaction_data):
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

    hybrid_recommend = get_hybrid_recommend_users(user_id, interest_similarity_matrix, interaction_similarity_matrix,
                                                  user_item_matrix, user_data,
                                                  content_weight=0.6, threshold=0)
    output = print_user_info_from_user_ids(user_data[['id', 'name']], hybrid_recommend,
                                           ).sort_values('hybrid_score', ascending=False)
    return output



def _fetchAllUserData():
    firebase_admin.initialize_app()
    db = firestore.client()
    users_collection = db.collection("users")
    interactionsCollection = db.collection("interaction")
    # print users collections
    print_all_docs_in_collection(users_collection)
    return users_collection
