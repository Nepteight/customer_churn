-- ============================================================
-- 03.1. CHURN RATE BY TENURE GROUP
-- ============================================================
SELECT
    CASE
        WHEN tenure BETWEEN 1 AND 12 THEN '1-12 months'
        WHEN tenure BETWEEN 13 AND 24 THEN '13-24 months'
        WHEN tenure BETWEEN 25 AND 36 THEN '25-36 months'
        WHEN tenure BETWEEN 37 AND 48 THEN '37-48 months'
        WHEN tenure BETWEEN 49 AND 60 THEN '49-60 months'
    ELSE 'Unknown'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS churn_rate
FROM
    customer_churn
GROUP BY
    tenure_group
ORDER BY
    churn_rate DESC;

-- ============================================================
-- 03.2. AVERAGE TENURE BY CUSTOMER STATUS
-- ============================================================
SELECT
  CASE WHEN churn = 1 THEN 'Churned' WHEN churn = 0 THEN 'Retained' END AS customer_status,
  COUNT(*) AS total_customers,
  ROUND(
    AVG(tenure),
    2
  ) AS avg_tenure
FROM
  customer_churn
GROUP BY
  churn
ORDER BY
  churn DESC;
