-- Customer churn segments — IBM Telco Customer Churn dataset
-- SQLite-compatible. Assumes the CSV was loaded into a table called telco_churn
-- with the dataset's own column names (Churn is 'Yes' / 'No').
--
-- Data note: TotalCharges arrives as text, and 11 rows have a blank value.
-- All 11 are zero-tenure, brand-new customers. Cast it before using it:
--   CAST(NULLIF(TotalCharges, '') AS REAL)

-- 1. Overall churn rate
SELECT COUNT(*) AS total_customers,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
       ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM telco_churn;

-- 2. Churn by contract type
SELECT Contract,
       COUNT(*) AS customers,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
       ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS churn_rate_pct
FROM telco_churn
GROUP BY Contract
ORDER BY churn_rate_pct DESC;

-- 3. Churn by payment method
SELECT PaymentMethod,
       COUNT(*) AS customers,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
       ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS churn_rate_pct
FROM telco_churn
GROUP BY PaymentMethod
ORDER BY churn_rate_pct DESC;

-- 4. Churn by tenure band
SELECT CASE
         WHEN tenure <= 6 THEN '0-6 months'
         WHEN tenure <= 12 THEN '7-12 months'
         WHEN tenure <= 24 THEN '13-24 months'
         WHEN tenure <= 48 THEN '25-48 months'
         ELSE 'Over 48 months'
       END AS tenure_band,
       COUNT(*) AS customers,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
       ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS churn_rate_pct
FROM telco_churn
GROUP BY tenure_band
ORDER BY MIN(tenure);

-- 5. The highest-risk segment: month-to-month customers in their first 12 months
SELECT COUNT(*) AS segment_customers,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
       ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS churn_rate_pct
FROM telco_churn
WHERE Contract = 'Month-to-month'
  AND tenure <= 12;

-- 6. Churn by TechSupport among month-to-month customers
SELECT TechSupport,
       COUNT(*) AS customers,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
       ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS churn_rate_pct
FROM telco_churn
WHERE Contract = 'Month-to-month'
GROUP BY TechSupport
ORDER BY churn_rate_pct DESC;
