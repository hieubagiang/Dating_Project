import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

# Load users_df
users_df = pd.read_csv('user_data.csv')
# Preprocess users_df
tfidf = TfidfVectorizer(stop_words='english')
users_df['text'] = users_df['interests'].fillna('')
tfidf_matrix = tfidf.fit_transform(users_df['text'])

# Compute cosine similarity
cosine_sim = cosine_similarity(tfidf_matrix, tfidf_matrix)


# Recommend similar users
def get_content_based_recommend_users(user_id, cosine_sim, users_df):
    indices = pd.Series(users_df.index, index=users_df['id'])
    idx = indices[user_id]
    similarity_scores = list(enumerate(cosine_sim[idx]))
    similarity_scores = sorted(similarity_scores, key=lambda x: x[1], reverse=True)
    similarity_scores = similarity_scores[1:]
    user_indices = [i[0] for i in similarity_scores]
    user_scores = [i[1] for i in similarity_scores]
    result_df = users_df[['id', 'name']].iloc[user_indices].copy()
    result_df['similarity_score'] = user_scores
    return result_df

# Example usage
output = get_content_based_recommend_users(1, cosine_sim, users_df)
print(output)
# Print all user similarity scores
# for i, user in enumerate(users_df.index):
#     similarity_scores = [{'similarity_score': score, 'id': j} for j, score in enumerate(cosine_sim[i])]
#     similarity_scores_sorted = sorted(similarity_scores, key=lambda x: x['similarity_score'], reverse=True)
#     print(f"user_{user}:")
#     print(similarity_scores_sorted)
#     print()

exit(0)
