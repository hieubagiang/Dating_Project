from faker import Faker
import random
import csv
from api.models.hobby_enum import Hobby

# Initialize Faker
fake = Faker()

# Define interests
# get hobby from list enum Hobby
interests = [hobby.name for hobby in Hobby]
# Generate user data
with open('user_data.csv', mode='w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['id', 'name', 'age', 'interests'])
    for i in range(10):
        name = fake.name()
        age = random.randint(18, 40)
        num_interests = random.randint(1, len(interests))
        user_interests = random.sample(interests, num_interests)
        writer.writerow([i+1, name, age, ','.join(user_interests)])
