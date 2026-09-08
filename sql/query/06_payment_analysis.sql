-- ============================================================
-- 06.1. CHURN RATE BY PAYMENT DELAY
-- ============================================================
SELECT
  CASE WHEN payment_delay BETWEEN 0
  AND 5 THEN '0-5 days' WHEN payment_delay BETWEEN 6
  AND 10 THEN '6-10 days' WHEN payment_delay BETWEEN 11
  AND 15 THEN '11-15 days' WHEN payment_delay BETWEEN 16
  AND 20 THEN '16-20 days' WHEN payment_delay BETWEEN 21
  AND 25 THEN '21-25 days' WHEN payment_delay BETWEEN 26
  AND 30 THEN '26-30 days' ELSE 'Unknown' END AS payment_delay_group,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(
    100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS churn_rate
FROM
  customer_churn
GROUP BY
  payment_delay_group
ORDER BY
  churn_rate DESC;

-- ============================================================
-- 06.2. AVERAGE PAYMENT DELAY BY CUSTOMER STATUS
-- ============================================================
SELECT
  CASE WHEN churn = 1 THEN 'Churned' WHEN churn = 0 THEN 'Retained' END AS customer_status,
  COUNT(*) AS total_customers,
  ROUND(
    AVG(payment_delay),
    2
  ) AS avg_payment_delay
FROM
  customer_churn
GROUP BY
  churn
ORDER BY
  churn DESC;
