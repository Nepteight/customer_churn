-- ============================================================
-- 02.1. CHURN RATE BY GENDER
-- ============================================================
SELECT
    gender,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
    100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) / COUNT(*),
    2
    ) AS churn_rate
FROM
    customer_churn
GROUP BY
    gender
ORDER BY
    churn_rate DESC;

-- ============================================================
-- 02.2. CHURN RATE BY AGE GROUP
-- ============================================================
SELECT
  CASE WHEN age BETWEEN 18
  AND 25 THEN '18-25' WHEN age BETWEEN 26
  AND 35 THEN '26-35' WHEN age BETWEEN 36
  AND 45 THEN '36-45' WHEN age BETWEEN 46
  AND 55 THEN '46-55' WHEN age BETWEEN 56
  AND 65 THEN '56-65' ELSE 'Unknown' END AS age_group,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(
    100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS churn_rate
FROM
  customer_churn
GROUP BY
  age_group
ORDER BY
  churn_rate DESC;
