-- ============================================================
-- 05.1. CHURN RATE BY SUPPORT CALLS
-- ============================================================
SELECT
  CASE WHEN support_calls BETWEEN 0
  AND 2 THEN '0-2' WHEN support_calls BETWEEN 3
  AND 4 THEN '3-4' WHEN support_calls BETWEEN 5
  AND 6 THEN '5-6' WHEN support_calls BETWEEN 7
  AND 8 THEN '7-8' WHEN support_calls BETWEEN 9
  AND 10 THEN '9-10' ELSE 'Unknown' END AS support_calls_group,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(
    100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS churn_rate
FROM
  customer_churn
GROUP BY
  support_calls_group
ORDER BY
  churn_rate DESC;

-- ============================================================
-- 05.2. AVERAGE SUPPORT CALLS BY CUSTOMER STATUS
-- ============================================================
SELECT
  CASE WHEN churn = 1 THEN 'Churned' WHEN churn = 0 THEN 'Retained' END AS customer_status,
  COUNT(*) AS total_customers,
  ROUND(
    AVG(support_calls),
    2
  ) AS avg_support_calls
FROM
  customer_churn
GROUP BY
  churn
ORDER BY
  churn DESC;
