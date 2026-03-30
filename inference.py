import pandas as pd
import joblib

class ReplitPropensityScorer:
    def __init__(self, model_path):
        self.model = joblib.load(model_path)

    def preprocess(self, raw_data):
        # Ensure columns match the training features
        features = ['repls_created', 'minutes_coded', 'multiplayer_invites', 
                    'deployments', 'is_professional_email']
        return raw_data[features]

    def predict_high_intent(self, user_df, threshold=0.75):
        """Returns users likely to convert for targeted marketing."""
        processed_df = self.preprocess(user_df)
        probs = self.model.predict_proba(processed_df)[:, 1]
        user_df['propensity_score'] = probs
        return user_df[user_df['propensity_score'] >= threshold]

# Example Usage:
# scorer = ReplitPropensityScorer('models/xgb_model.pkl')
# high_intent_users = scorer.predict_high_intent(new_signups_df)
