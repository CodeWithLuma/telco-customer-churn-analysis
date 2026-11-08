# Customer Churn Analysis — IBM Telco Dataset

Which customers leave, why do they leave, and what should a retention team do about it?

## The dataset

- IBM Telco Customer Churn dataset, public on Kaggle: https://www.kaggle.com/datasets/blastchar/telco-customer-churn
- File: `WA_Fn-UseC_-Telco-Customer-Churn.csv` — 7,043 customers, 21 columns, one row per customer.
- Honest note: IBM created this dataset for educational use. It may not reflect any real telecom company's customer base. This is a portfolio project on a public sample dataset — the findings describe this dataset, not a real company.

## What's in this repo

- `notebooks/01-churn-analysis.ipynb` — the full analysis in Python (pandas, matplotlib)
- `sql/churn_segments.sql` — the same key questions answered in SQL (SQLite-compatible)
- `data/DATA_SOURCE.md` — where to download the CSV
- `requirements.txt` — Python packages

## How to run it

1. Download the CSV from the Kaggle link above into `data/`.
2. `pip install -r requirements.txt`
3. Open `notebooks/01-churn-analysis.ipynb` and run it top to bottom.

## Key findings

- 1,869 of 7,043 customers churned — 26.54%.
- Contract matters most: month-to-month customers churn at 42.7%, one-year at 11.3%, two-year at 2.8%. Month-to-month customers are about 15x more likely to churn than two-year customers.
- Internet service: fiber optic customers churn at 41.9%, DSL at 19.0%.
- Payment method: electronic check 45.3% churn, vs about 15–17% for automatic bank transfer or credit card.
- Tenure: 47.4% of customers churn in their first 12 months, about 52% in the first 6 months. After 4 years, churn drops to about 8–9.5%. Median tenure is 10 months for churned customers vs 38 months for customers who stayed.
- Highest-risk segment: month-to-month customers in their first 12 months churn at 51.4%. Among month-to-month customers, those without TechSupport churn at 50.4% vs 30.7% with TechSupport.
- Senior citizens churn at 41.7% vs 23.6% for others. Churned customers paid $74.44 a month on average vs $61.27 for customers who stayed.
- Revenue at risk: $139,131 in monthly recurring revenue from churned customers (per a published analysis of this dataset).

## What the retention team should do

1. Nudge month-to-month customers onto one-year or two-year contracts — 42.7% churn vs 2.8% is the biggest gap in the data.
2. Protect the first year. With 47.4% churning in the first 12 months and about 52% in the first 6, onboarding check-ins in months 1–6 matter most.
3. Look at fiber optic service quality. Fiber customers churn at 41.9% vs 19.0% for DSL — that points to a service or support problem, not a pricing one.
4. Move electronic-check payers to autopay and offer TechSupport to month-to-month customers — 45.3% vs about 15–17% on payment method, and 50.4% vs 30.7% on TechSupport.

## Data quality note

- `TotalCharges` is stored as text. 11 rows have a blank value — all 11 are zero-tenure, brand-new customers. The notebook converts the column to numeric and treats blanks as 0.

## Limitations

- This is a sample dataset made for learning. The patterns describe this dataset; they are associations, not proof of cause.
- There is no complaint, outage, or customer-service data here, so the "why" behind fiber churn and early churn is a question for follow-up, not something this data can answer on its own.

## Tools

Python (pandas, NumPy, matplotlib), SQL (SQLite).
