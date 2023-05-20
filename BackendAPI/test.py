import numpy as np
import pandas as pd
from sklearn.metrics.pairwise import cosine_similarity

user_item_matrix = np.array([    [0, 2, 1, 0, 0],
                                 [2, 0, 0, 1, 1],
                                 [0, 1, 0, 2, 2],
                                 [1, 0, 2, 0, 0],
                                 [0, 0, 1, 1, 0],
                                 ])

# create a DataFrame from the user-item matrix
df = pd.DataFrame(user_item_matrix, columns=['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'], index=['User 1', 'User 2', 'User 3', 'User 4', 'User 5'])

# print the DataFrame
print(df)

# similarity matrix between users
user_similarities = cosine_similarity(user_item_matrix)

user_id = 0
k = 2
similar_users = np.argsort(user_similarities[user_id])[::-1][1:k+1]

unrated_users = np.where(user_item_matrix[user_id] == 0)[0]
item_ratings = user_item_matrix[similar_users][:, unrated_users]

similarities = user_similarities[user_id][similar_users].reshape(-1, 1)
weighted_ratings = item_ratings * similarities
item_averages = np.sum(weighted_ratings, axis=0) / np.sum(similarities)

recommended_users = np.argsort(item_averages)[::-1]
print("Recommended users:", recommended_users)

# assume user 0 likes user 3 and dislikes user 4
user_item_matrix[user_id, 3] = 2
user_item_matrix[user_id, 4] = 1
