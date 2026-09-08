-- ============================================================
-- 04.1. CHURN RATE BY USAGE FREQUENCY
-- ============================================================
SELECT
  CASE
    WHEN usage_frequency BETWEEN 1 AND 5 THEN '1-5'
    WHEN usage_frequency BETWEEN 6 AND 10 THEN '6-10'
    WHEN usage_frequency BETWEEN 11 AND 15 THEN '11-15'
    WHEN usage_frequency BETWEEN 16 AND 20 THEN '16-20'
    WHEN usage_frequency BETWEEN 21 AND 25 THEN '21-25'
    WHEN usage_frequency BETWEEN 26 AND 30 THEN '26-30'
    ELSE 'Unknown'
  END AS usage_frequency_group,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(
    100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS churn_rate
FROM
  customer_churn
GROUP BY
  usage_frequency_group
ORDER BY
  churn_rate DESC;

-- ============================================================
-- 04.2. AVERAGE USAGE FREQUENCY BY CUSTOMER STATUS
-- ============================================================
SELECT
  CASE
    WHEN churn = 1 THEN 'Churned'
    WHEN churn = 0 THEN 'Retained'
    END AS customer_status,
  COUNT(*) AS total_customers,
  ROUND(
    AVG(usage_frequency),
    2
  ) AS avg_usage_frequency
FROM
  customer_churn
GROUP BY
  churn
ORDER BY
  churn DESC;

-- ============================================================
-- 04.3. CHURN RATE BY LAST INTERACTION
-- ============================================================
SELECT
  CASE WHEN last_interaction BETWEEN 1
  AND 5 THEN '1-5 days' WHEN last_interaction BETWEEN 6
  AND 10 THEN '6-10 days' WHEN last_interaction BETWEEN 11
  AND 15 THEN '11-15 days' WHEN last_interaction BETWEEN 16
  AND 20 THEN '16-20 days' WHEN last_interaction BETWEEN 21
  AND 25 THEN '21-25 days' WHEN last_interaction BETWEEN 26
  AND 30 THEN '26-30 days' ELSE 'Unknown' END AS last_interaction_group,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(
    100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS churn_rate
FROM
  customer_churn
GROUP BY
  last_interaction_group
ORDER BY
  churn_rate DESC;
