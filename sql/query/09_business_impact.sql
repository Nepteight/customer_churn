-- ============================================================
-- 09.1. CUSTOMER VALUE LOST DUE TO CHURN
-- ============================================================
SELECT
  COUNT(*) AS churned_customers,
  ROUND(
    SUM(total_spend),
    2
  ) AS total_spend_lost,
  ROUND(
    AVG(total_spend),
    2
  ) AS avg_spend_per_churned_customer
FROM
  customer_churn
WHERE
  churn = 1;

-- ============================================================
-- 09.2. KEY HIGH-RISK INDICATORS
-- ============================================================
SELECT
  COUNT(*) AS total_customers,
  ROUND(
    100.0 * COUNT(
      CASE WHEN contract_length = 'Monthly' THEN 1 END
    ) / NULLIF(
      COUNT(*),
      0
    ),
    2
  ) AS monthly_contract_pct,
  ROUND(
    100.0 * COUNT(
      CASE WHEN support_calls >= 7 THEN 1 END
    ) / NULLIF(
      COUNT(*),
      0
    ),
    2
  ) AS high_support_calls_pct,
  ROUND(
    100.0 * COUNT(
      CASE WHEN payment_delay >= 21 THEN 1 END
    ) / NULLIF(
      COUNT(*),
      0
    ),
    2
  ) AS high_payment_delay_pct
FROM
  customer_churn;

