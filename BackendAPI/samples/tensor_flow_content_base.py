import pandas as pd
import tensorflow as tf

# Load data
from keras.layers import TextVectorization

data = pd.read_csv('user_data.csv')

# Preprocess data
data['text'] = data['interests'].fillna('')
vectorizer = TextVectorization(max_tokens=1000, output_mode='tf-idf')
vectorizer.adapt(data['text'])
tfidf_matrix = vectorizer(data['text'])

# Build model
model = tf.keras.Sequential([
    tf.keras.layers.Dense(64, activation='relu', input_shape=[tfidf_matrix.shape[1]]),
    tf.keras.layers.Dropout(0.5),
    tf.keras.layers.Dense(32, activation='relu'),
    tf.keras.layers.Dropout(0.5),
    tf.keras.layers.Dense(16, activation='relu'),
    tf.keras.layers.Dropout(0.5),
    tf.keras.layers.Dense(data.shape[0], activation='softmax')
])
model.compile(loss='categorical_crossentropy', optimizer='adam')

# Train model
model.fit(tfidf_matrix, tfidf_matrix, epochs=50)

# Recommend similar users
def recommend_users(user_id, data, vectorizer, model):
    user_text = data.loc[data['id'] == user_id]['text']
    user_vector = vectorizer(user_text).numpy()
    scores = model.predict(user_vector)[0]
    similar_users = data.loc[data['id'] != user_id].copy()
    similar_users['score'] = scores[:-1]
    similar_users = similar_users.sort_values(by='score', ascending=False).head(10)
    return similar_users[['id', 'name', 'age']]

# Example usage
output = recommend_users(1, data, vectorizer, model)
print(output)
