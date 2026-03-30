import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from xgboost import XGBClassifier
from sklearn.metrics import classification_report, roc_auc_score

# 1. Generate Synthetic Developer Activity Data
np.random.seed(42)
n_users = 5000

data = {
    'user_id': range(n_users),
    # Features (First 7 days of activity)
    'repls_created': np.random.poisson(3, n_users),
    'minutes_coded': np.random.exponential(100, n_users),
    'multiplayer_invites': np.random.poisson(0.5, n_users),
    'deployments': np.random.poisson(0.2, n_users),
    'is_professional_email': np.random.choice([0, 1], n_users, p=[0.8, 0.2])
}

df = pd.DataFrame(data)

# 2. Create a "Hidden" logic for conversion (The ground truth)
# Users are more likely to convert if they deploy or collaborate
logit = (
    0.5 * df['deployments'] + 
    0.8 * df['multiplayer_invites'] + 
    0.01 * df['minutes_coded'] + 
    1.5 * df['is_professional_email'] - 5
)
prob = 1 / (1 + np.exp(-logit))
df['converted'] = np.random.binomial(1, prob)

print(f"Conversion Rate: {df['converted'].mean()*100:.2f}%")
