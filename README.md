Replit Propensity Engine: Predicting Core Conversions
Business Problem
Replit operates on a freemium model where millions of developers use the IDE for free. To optimize Marketing ROI and CAC (Customer Acquisition Cost), the growth team needs to identify "High-Intent" users early in their lifecycle to trigger personalized conversion offers.

The Solution
I developed an end-to-end Propensity Model that analyzes a user's first 7 days of activity to predict the likelihood of upgrading to a Replit Core plan within 30 days.

Key Technical Features

Feature Engineering (SQL): Aggregated event-level logs (deployments, multiplayer invites, coding minutes) using window functions in BigQuery.


Predictive Modeling (Python): Trained an XGBoost Classifier to handle skewed behavioral data.

Aha! Moment Discovery: Utilized SHAP values to identify that 3+ successful deployments is the leading indicator of conversion.

Impact

Precision: 85% at identifying high-intent users.


Strategic Insight: Found that "Social Coding" (Multiplayer invites) increases conversion probability by 3x.
