-- Target: Build a 7-day snapshot of user behavior for propensity scoring
WITH user_behavior AS (
    SELECT 
        user_id,
        COUNT(CASE WHEN event_name = 'repl_created' THEN 1 END) AS total_repls,
        SUM(session_duration_ms) / 60000 AS total_minutes_coded,
        COUNT(CASE WHEN event_name = 'multiplayer_invite' THEN 1 END) AS collab_actions,
        COUNT(CASE WHEN event_name = 'deployment_success' THEN 1 END) AS successful_deployments
    FROM `replit-production.events.user_logs`
    WHERE event_timestamp BETWEEN signup_date AND TIMESTAMP_ADD(signup_date, INTERVAL 7 DAY)
    GROUP BY 1
)
SELECT 
    b.*,
    u.is_pro_email_domain,
    CASE WHEN s.subscription_id IS NOT NULL THEN 1 ELSE 0 END AS label_converted
FROM user_behavior b
JOIN `replit-production.users.profiles` u ON b.user_id = u.user_id
LEFT JOIN `replit-production.billing.subscriptions` s 
    ON b.user_id = s.user_id 
    AND s.created_at <= TIMESTAMP_ADD(b.signup_date, INTERVAL 30 DAY);
