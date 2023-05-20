import pandas as pd
from sklearn.metrics.pairwise import cosine_similarity

# Load data
user_data = pd.read_csv('user_data.csv')
interaction_data = pd.read_csv('interaction_data.csv')

# Merge user and interaction data
merged_data = pd.merge(interaction_data, user_data, on='id')

# Compute user-user similarity matrix
user_item_matrix = merged_data.pivot_table(index='id', columns='interacted_user_id', values='interact_type',
                                           fill_value=0)
user_similarity_matrix = cosine_similarity(user_item_matrix)


def get_collaborative_filter_recommend_users(user_id, user_similarity_matrix, user_data):
    # Get similarity scores for the given user
    similarity_scores = list(enumerate(user_similarity_matrix[user_id]))

    # Sort the similarity scores in descending order
    similarity_scores = sorted(similarity_scores, key=lambda x: x[1], reverse=True)

    similarity_scores = similarity_scores[1:]
    user_indices = [i[0] for i in similarity_scores]
    user_scores = [i[1] for i in similarity_scores]
    result_df = user_data[['id', 'name']].iloc[user_indices].copy()
    result_df['similarity_score'] = user_scores
    return result_df

recommended_users = get_collaborative_filter_recommend_users(1, user_similarity_matrix, user_data, )
print(recommended_users)
exit(0)
