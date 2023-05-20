import csv

from faker import Faker
import pandas as pd

# Initialize Faker object
from faker.generator import random

from api.models.hobby_enum import Hobby

fake = Faker()
# Define interests
# get hobby from list enum Hobby
interests = [hobby.name for hobby in Hobby]
userNeedToCreate = 100
interactionsNeedToCreate = 400
# Generate user data
with open('user_data.csv', mode='w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['id', 'name', 'age', 'interests'])
    for i in range(userNeedToCreate):
        name = fake.name()
        age = random.randint(18, 40)
        num_interests = random.randint(1, 10)
        user_interests = random.sample(interests, num_interests)
        writer.writerow([i+1, name, age, ','.join(user_interests)])
user_data = pd.read_csv('user_data.csv')

user_ids = user_data['id'].tolist()
num_interactions = interactionsNeedToCreate

interactions = []

for i in range(num_interactions):
    current_user_id = random.choice(user_ids)
    interacted_user_id = random.choice([uid for uid in user_ids if uid != current_user_id])
    interact_type = random.choice([1, 2])
    interactions.append((current_user_id, interacted_user_id, interact_type))

interactive_data = pd.DataFrame(interactions, columns=['id', 'interacted_user_id', 'interact_type'])

print(interactive_data)


# save data to CSV files
user_data.to_csv('user_data.csv', index=False)
interactive_data.to_csv('item_data.csv', index=False)
exit(0)
