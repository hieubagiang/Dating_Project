import numpy as np
from sklearn.metrics.pairwise import cosine_similarity

# create a user-item matrix
user_item_matrix = np.array([
    [5, 3, 0, 1],
    [4, 0, 0, 1],
    [1, 1, 0, 5],
    [1, 0, 0, 4],
    [0, 1, 5, 4],
])

# compute the similarity between users
user_similarities = cosine_similarity(user_item_matrix)

# find the k most similar users
user_id = 2
k = 2
similar_users = np.argsort(user_similarities[user_id])[::-1][1:k+1]

# recommend items to the user
item_ratings = user_item_matrix[similar_users]
item_ratings[item_ratings == 0] = np.nan
item_averages = np.nanmean(item_ratings, axis=0)
recommended_items = np.argsort(item_averages)[::-1]

# print(recommended_items)
