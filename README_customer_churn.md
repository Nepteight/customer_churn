# Customer Churn Analysis

A data analytics project that analyzes customer churn patterns, identifies high-risk customer segments, and evaluates the potential business impact of customer churn.

**GitHub Repository:** https://github.com/Nepteight/customer_churn

---

## 1. Project Overview

Customer churn is an important business problem because losing customers can reduce revenue and increase the cost of acquiring new customers.

This project analyzes customer data to answer the following business question:

> **How can the company leverage customer data to identify factors associated with churn, detect high-risk customer segments, and develop effective strategies to improve customer retention?**

The project uses **Python, PostgreSQL, SQL, and Power BI** as the main tools.

### Project Objectives

- Clean and prepare the customer churn dataset.
- Explore customer characteristics and churn distribution.
- Analyze churn using SQL and PostgreSQL.
- Identify behavioral and service-related factors associated with churn.
- Identify high-risk customer segments.
- Evaluate historical spend associated with churned customers.
- Build an interactive Power BI dashboard.
- Provide data-driven recommendations for customer retention.

---

## 2. Project Workflow

The project follows this workflow:

```text
Raw CSV Dataset
      ↓
Python Data Cleaning
      ↓
Cleaned CSV Dataset
      ↓
PostgreSQL
      ↓
SQL Analysis
      ↓
Power BI
      ↓
Dashboard & Business Insights
```

---

## 3. Dataset

The main dataset is:

```text
customer_churn_dataset-training-master.csv
```

The dataset contains customer demographic, behavioral, payment, subscription, and churn information.

### Main Columns

| Column | Description |
|---|---|
| `CustomerID` | Unique customer identifier |
| `Age` | Customer age |
| `Gender` | Customer gender |
| `Tenure` | Customer tenure |
| `Usage Frequency` | Frequency of service usage |
| `Support Calls` | Number of support calls |
| `Payment Delay` | Payment delay |
| `Subscription Type` | Customer subscription type |
| `Contract Length` | Contract duration |
| `Total Spend` | Customer total spend |
| `Last Interaction` | Number of days since the last interaction |
| `Churn` | Churn indicator: 1 = Churned, 0 = Retained |

After removing the completely empty row, the dataset contains:

- **440,832 customers**
- **249,999 churned customers**
- **190,833 retained customers**
- **56.71% overall churn rate**
- **43.29% retention rate**

---

## 4. Project Structure

```text
customer_churn/
│
├── data/
│   ├── raw/
│   │   └── customer_churn_dataset-training-master.csv
│   │
│   └── cleaned/
│       └── customer_churn_cleaned.csv
│
├── python/
│   └── customer_churn_cleaning.ipynb
│
├── sql/
│   ├── 01_overall_churn.sql
│   ├── 02_demographic_analysis.sql
│   ├── 03_tenure_analysis.sql
│   ├── 04_engagement_analysis.sql
│   ├── 05_support_analysis.sql
│   ├── 06_payment_analysis.sql
│   ├── 07_subscription_analysis.sql
│   ├── 08_high_risk_segments.sql
│   └── 09_business_impact.sql
│
├── power_bi/
│   └── customer_churn_analysis.pbix
│
└── README.md
```

> File and folder names may differ slightly depending on the current version of the repository.

---

# 5. How to Use This Project

## Step 1 — Clone the Repository

Open a terminal and run:

```bash
git clone https://github.com/Nepteight/customer_churn.git
cd customer_churn
```

You can also download the repository as a ZIP file from GitHub.

---

## Step 2 — Prepare Python Environment

Make sure Python is installed.

Recommended Python version:

```text
Python 3.x
```

Install the required libraries:

```bash
pip install pandas numpy sqlalchemy psycopg2-binary jupyter
```

If you use a virtual environment, create and activate it first:

### Windows

```bash
python -m venv .venv
.venv\Scripts\activate
```

Then install the packages:

```bash
pip install pandas numpy sqlalchemy psycopg2-binary jupyter
```

---

# 6. Run Data Cleaning with Python

Open:

```text
python/customer_churn_cleaning.ipynb
```

Run the notebook from top to bottom.

The notebook performs the following steps:

### 6.1 Load the raw dataset

```python
import pandas as pd

df = pd.read_csv(
    "data/raw/customer_churn_dataset-training-master.csv"
)
```

### 6.2 Check data structure

The notebook checks:

- Number of rows and columns
- Data types
- Missing values
- Duplicate rows
- Duplicate customer IDs
- Unique categorical values
- Numeric ranges

### 6.3 Remove completely empty rows

The original dataset contains one completely empty row.

It is removed using:

```python
df = df.dropna(how="all")
```

### 6.4 Clean data types

Numeric columns are converted using:

```python
pd.to_numeric(..., errors="coerce")
```

The notebook also handles:

- Integer columns
- `Total Spend`
- Categorical text values
- Invalid values
- Missing values after conversion

### 6.5 Convert column names to snake_case

The final column naming convention is:

```text
customerid
age
gender
tenure
usage_frequency
support_calls
payment_delay
subscription_type
contract_length
total_spend
last_interaction
churn
```

### 6.6 Export the cleaned dataset

The cleaned dataset is exported as:

```text
data/cleaned/customer_churn_cleaned.csv
```

---

# 7. Load Data into PostgreSQL

## 7.1 Create the database

Create a PostgreSQL database named:

```text
customer_churn
```

The default connection used in the project is:

```text
Host: localhost
Port: 5432
Username: postgres
Database: customer_churn
```

Update the password in your local environment if necessary.

---

## 7.2 Connect Python to PostgreSQL

Example connection:

```python
from sqlalchemy import create_engine

username = "postgres"
password = "YOUR_PASSWORD"
host = "localhost"
port = "5432"
database = "customer_churn"

connection_string = (
    f"postgresql+psycopg2://"
    f"{username}:{password}@"
    f"{host}:{port}/{database}"
)

engine = create_engine(connection_string)
```

> Do not commit your real PostgreSQL password to GitHub.

---

## 7.3 Load the cleaned dataset

The recommended PostgreSQL table name is:

```text
customer_churn
```

The project uses explicit data types for important columns.

For example:

```python
from sqlalchemy.types import String, Integer, Numeric

df.to_sql(
    "customer_churn",
    engine,
    if_exists="replace",
    index=False,
    dtype={
        "customerid": String(50),
        "age": Integer(),
        "gender": String(20),
        "tenure": Integer(),
        "usage_frequency": Integer(),
        "support_calls": Integer(),
        "payment_delay": Integer(),
        "subscription_type": String(20),
        "contract_length": String(20),
        "total_spend": Numeric(12, 2),
        "last_interaction": Integer(),
        "churn": Integer()
    }
)
```

---

# 8. Run SQL Analysis

The SQL analysis is divided into separate files so that each business question can be analyzed independently.

## 8.1 Overall Churn

File:

```text
sql/01_overall_churn.sql
```

Answers:

- Total customers
- Churned customers
- Retained customers
- Overall churn rate
- Retention rate

Expected overall result:

```text
Total Customers:     440,832
Churned Customers:   249,999
Retained Customers:  190,833
Churn Rate:          56.71%
Retention Rate:      43.29%
```

---

## 8.2 Demographic Analysis

File:

```text
sql/02_demographic_analysis.sql
```

Analyzes churn by:

- Gender
- Age group

Important observed results include:

| Group | Churn Rate |
|---|---:|
| Female | 66.67% |
| Male | 49.13% |
| Age 18–25 | 56.43% |
| Age 26–35 | 49.12% |
| Age 36–45 | 42.80% |
| Age 46–55 | 57.85% |
| Age 56–65 | 100.00% |

---

## 8.3 Tenure Analysis

File:

```text
sql/03_tenure_analysis.sql
```

Analyzes the relationship between customer tenure and churn.

Tenure groups:

```text
1–12
13–24
25–36
37–48
49–60
```

The highest observed churn rate is:

```text
13–24 months → 63.27%
```

---

## 8.4 Engagement Analysis

File:

```text
sql/04_engagement_analysis.sql
```

Analyzes:

- Usage Frequency
- Last Interaction
- Average usage frequency

Important observations:

- Customers with usage frequency of **1–5** had a churn rate of **61.50%**.
- Customers with last interaction of **21–25** had a churn rate of **66.66%**.
- Average usage frequency:
  - Churned: **15.46**
  - Retained: **16.26**

---

## 8.5 Support Analysis

File:

```text
sql/05_support_analysis.sql
```

Analyzes the relationship between support calls and churn.

Important result:

```text
Support Calls 5–6 → 97.28% churn
Support Calls 7–8 → 100.00% churn
Support Calls 9–10 → 100.00% churn
```

Average support calls:

```text
Churned:  5.14
Retained: 1.59
```

---

## 8.6 Payment Analysis

File:

```text
sql/06_payment_analysis.sql
```

Analyzes payment delay and churn.

Important result:

```text
Payment Delay 21–25 → 100.00% churn
Payment Delay 26–30 → 100.00% churn
```

Average payment delay:

```text
Churned:  15.22
Retained: 10.02
```

---

## 8.7 Subscription and Contract Analysis

File:

```text
sql/07_subscription_analysis.sql
```

### Subscription Type

| Subscription Type | Churn Rate |
|---|---:|
| Basic | **58.18%** |
| Standard | **56.07%** |
| Premium | **55.94%** |

### Contract Length

| Contract Length | Churn Rate |
|---|---:|
| Monthly | **100.00%** |
| Annual | **46.08%** |
| Quarterly | **46.03%** |

Contract length shows a much larger difference in observed churn rates than subscription type.

---

# 9. High-Risk Customer Analysis

File:

```text
sql/08_high_risk_segments.sql
```

This analysis combines:

- Contract Length
- Support Risk
- Payment Risk
- Engagement Risk

to identify customer segments with high observed churn rates.

Examples:

| Contract | Support | Payment | Engagement | Churn Rate |
|---|---|---|---|---:|
| Monthly | Low | Low | Normal | **100.00%** |
| Monthly | Low | High | Low | **100.00%** |
| Monthly | High | Low | Low | **100.00%** |
| Monthly | High | High | Normal | **100.00%** |
| Quarterly | High | High | Low | **99.56%** |
| Annual | High | High | Low | **99.50%** |

The detailed customer-level analysis contains:

```text
249,999 churned customers
```

Each customer is assigned a `risk_score` from **0 to 5** based on predefined risk indicators.

---

# 10. Business Impact Analysis

File:

```text
sql/09_business_impact.sql
```

This analysis evaluates the historical customer spend associated with churned customers.

Results:

```text
Churned Customers:             249,999
Historical Spend:              135,320,840.60
Average Spend per Churned Customer: 541.29
```

The **135.32M** figure represents historical spend associated with churned customers. It should not be interpreted as confirmed future revenue loss.

---

# 11. Power BI Dashboard

Open:

```text
power_bi/customer_churn_analysis.pbix
```

The dashboard contains three main pages.

---

## Page 1 — Executive Overview

Purpose:

> Understand the overall customer churn situation.

Main components:

- Total Customers
- Churned Customers
- Retained Customers
- Churn Rate
- Retention Rate
- Churn vs Retained
- Churn Rate by Gender
- Churn Rate by Age Group
- Churn Rate by Contract Length
- Subscription Type slicer
- Gender slicer

The default slicer state should be **All** so that KPI values represent the complete dataset.

---

## Page 2 — Customer Behavior & Churn Drivers

Purpose:

> Identify customer behaviors associated with higher churn.

Main KPI cards:

- Average Usage Frequency
- Average Support Calls
- Average Payment Delay
- Average Last Interaction

Main charts:

1. Churn Rate by Usage Frequency Group
2. Churn Rate by Last Interaction Group
3. Churn Rate by Support Calls Group
4. Churn Rate by Payment Delay Group

---

## Page 3 — High-Risk Customers & Business Impact

Purpose:

> Identify high-risk customers and evaluate the business impact associated with churn.

Main KPI cards:

- High-Risk Customers
- High-Risk Churn Rate
- Churned Customers
- Historical Spend
- Average Spend

Main charts:

1. Customer Risk Indicators
2. Churn Rate by Customer Value
3. Churn Rate by Risk Score
4. Churned Customer Spend by Risk Score

---

# 12. Power BI Risk Score

The project uses five risk indicators:

```text
Monthly Contract
Support Calls >= 5
Payment Delay >= 15
Usage Frequency <= 10
Last Interaction >= 16
```

Each condition contributes one point.

Therefore:

```text
Risk Score = 0–5
```

A higher risk score represents a greater number of observed risk indicators.

The dashboard can then compare churn rates across different risk scores.

---

# 13. Key Findings

The analysis identified several important patterns:

### Overall Churn

The overall churn rate is **56.71%**, meaning that more than half of the customers in the analyzed dataset are classified as churned.

### Customer Demographics

Churn rates vary across demographic groups, with some age and gender groups showing substantially higher observed churn.

### Customer Behavior

Higher support activity, longer payment delays, and less recent interaction are associated with higher observed churn rates.

### Contract Length

Contract length shows one of the strongest differences:

```text
Monthly:   100.00%
Quarterly: 46.03%
Annual:    46.08%
```

### High-Risk Segments

Several combinations involving Monthly contracts show **100.00% observed churn rates**.

### Customer Value

Churned customers had approximately **135.32M in historical total spend**, with an average historical spend of **541.29 per churned customer**.

---

# 14. Business Recommendations

Based on the observed patterns, the business could consider:

### 1. Prioritize Monthly Contract Customers

Monthly customers show substantially higher observed churn rates than Quarterly and Annual customers.

Possible actions:

- Contract renewal incentives
- Longer-term plan benefits
- Personalized retention offers
- Early retention campaigns

### 2. Monitor Customers with High Support Activity

Customers with frequent support calls show considerably higher churn rates.

Possible actions:

- Identify recurring support issues
- Improve resolution time
- Follow up with customers after repeated support interactions
- Create proactive customer-care programs

### 3. Monitor Payment Delays

Customers with high payment delays should be prioritized for monitoring.

Possible actions:

- Payment reminders
- Flexible payment options
- Early intervention before severe payment delays occur

### 4. Re-engage Low-Engagement Customers

Customers with low usage frequency or long periods since their last interaction may require re-engagement.

Possible actions:

- Personalized campaigns
- Product/service recommendations
- Usage incentives
- Engagement notifications

### 5. Use Risk Scores for Customer Prioritization

The risk score can help the business prioritize customers based on the number of observed risk indicators.

Customers with higher scores can receive earlier retention attention.

---

# 15. Technologies Used

| Technology | Purpose |
|---|---|
| Python | Data cleaning and preparation |
| Pandas | Data manipulation |
| NumPy | Numerical processing |
| PostgreSQL | Data storage |
| SQL | Data analysis |
| SQLAlchemy | Python–PostgreSQL connection |
| Power BI | Dashboard and visualization |
| GitHub | Version control and project documentation |
| Jupyter Notebook | Python analysis |

---

# 16. Important Notes

### Churn vs Causation

The analysis identifies **associations and observed patterns** in the dataset. A high churn rate within a group does not necessarily mean that the corresponding factor directly causes churn.

### Historical Spend

The historical spend of churned customers represents spending recorded in the dataset before/at the point of churn. It should not automatically be interpreted as confirmed future revenue loss.

### Risk Score

The risk score is a project-defined analytical scoring system based on selected customer characteristics. It is intended for segmentation and prioritization rather than as a validated predictive model.

---

# 17. Future Improvements

Possible extensions to the project include:

- Build a machine learning churn prediction model.
- Compare Logistic Regression, Random Forest, XGBoost, and other classification models.
- Evaluate model performance using Precision, Recall, F1-score, ROC-AUC, and PR-AUC.
- Perform feature importance analysis.
- Create customer-level churn probability.
- Build an automated churn monitoring pipeline.
- Add the test dataset for prediction after completing the analytical stage.
- Improve the Power BI dashboard with additional drill-through functionality.

---

# 18. Author

**Nepteight**

GitHub:

https://github.com/Nepteight/customer_churn

---

## Project Summary

```text
Python
  ↓
Data Cleaning
  ↓
PostgreSQL
  ↓
SQL Analysis
  ↓
Power BI Dashboard
  ↓
Business Insights
  ↓
Customer Retention Recommendations
```

This project demonstrates an end-to-end **Data Analyst workflow**, from raw data preparation and SQL analysis to business intelligence visualization and actionable customer retention insights.
