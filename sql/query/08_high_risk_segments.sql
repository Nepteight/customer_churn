-- ============================================================
-- 08.1. HIGH-RISK CUSTOMER SEGMENTS
-- ============================================================
SELECT
  contract_length,
  CASE WHEN support_calls >= 5 THEN 'High Support Calls' ELSE 'Low Support Calls' END AS support_risk,
  CASE WHEN payment_delay >= 15 THEN 'High Payment Delay' ELSE 'Low Payment Delay' END AS payment_risk,
  CASE WHEN usage_frequency <= 10 THEN 'Low Usage' ELSE 'Normal Usage' END AS engagement_risk,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(
    100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS churn_rate
FROM
  customer_churn
GROUP BY
  contract_length,
  support_risk,
  payment_risk,
  engagement_risk
HAVING
  COUNT(*) >= 100
ORDER BY
  churn_rate DESC;

-- ============================================================
-- 08.2. CUSTOMER RISK SCORE
-- ============================================================
SELECT
  customerid,
  age,
  gender,
  tenure,
  usage_frequency,
  support_calls,
  payment_delay,
  subscription_type,
  contract_length,
  total_spend,
  last_interaction,
  churn,
  (
    CASE WHEN contract_length = 'Monthly' THEN 1 ELSE 0 END + CASE WHEN support_calls >= 5 THEN 1 ELSE 0 END + CASE WHEN payment_delay >= 15 THEN 1 ELSE 0 END + CASE WHEN usage_frequency <= 10 THEN 1 ELSE 0 END + CASE WHEN last_interaction >= 16 THEN 1 ELSE 0 END
  ) AS risk_score
FROM
  customer_churn
WHERE
  churn = 1
ORDER BY
  risk_score DESC;

-- ============================================================
-- 08.3. CHURNED VS RETAINED CUSTOMER PROFILE
-- ============================================================
SELECT
  CASE WHEN churn = 1 THEN 'Churned' WHEN churn = 0 THEN 'Retained' END AS customer_status,
  COUNT(*) AS total_customers,
  ROUND(
    AVG(age),
    2
  ) AS avg_age,
  ROUND(
    AVG(tenure),
    2
  ) AS avg_tenure,
  ROUND(
    AVG(usage_frequency),
    2
  ) AS avg_usage_frequency,
  ROUND(
    AVG(support_calls),
    2
  ) AS avg_support_calls,
  ROUND(
    AVG(payment_delay),
    2
  ) AS avg_payment_delay,
  ROUND(
    AVG(total_spend),
    2
  ) AS avg_total_spend,
  ROUND(
    AVG(last_interaction),
    2
  ) AS avg_last_interaction
FROM
  customer_churn
GROUP BY
  churn
ORDER BY
  churn DESC;
