-- ============================================================
-- 01. OVERALL CHURN RATE
-- ============================================================
SELECT
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
  SUM(CASE WHEN churn = 0 THEN 1 ELSE 0 END) AS retained_customers,
  ROUND(
    100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS churn_rate,
  ROUND(
    100.0 * SUM(CASE WHEN churn = 0 THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS retention_rate
FROM
  customer_churn;

