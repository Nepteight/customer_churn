-- ============================================================
-- 07.1. CHURN RATE BY SUBSCRIPTION TYPE
-- ============================================================
SELECT
  subscription_type,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(
    100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS churn_rate
FROM
  customer_churn
GROUP BY
  subscription_type
ORDER BY
  churn_rate DESC;

-- ============================================================
-- 07.2. CHURN RATE BY CONTRACT LENGTH
-- ============================================================
SELECT
  contract_length,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(
    100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS churn_rate
FROM
  customer_churn
GROUP BY
  contract_length
ORDER BY
  churn_rate DESC;
