# 🛒 Olist E-Commerce — SQL Analysis

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-336791?logo=postgresql)
![DBeaver](https://img.shields.io/badge/DBeaver-Community-372923?logo=dbeaver)
![Tableau](https://img.shields.io/badge/Tableau-Public-E97627?logo=tableau)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

> **Analyst:** Mohammad Taufik Ibrahim &nbsp;|&nbsp; **Date:** April 2026 &nbsp;|&nbsp; **Dataset:** Brazilian E-Commerce by Olist (99K+ orders)

---

## 📌 Project Overview

An end-to-end SQL analysis of 2 years of transactional data (October 2016 – August 2018) from **Olist**, the largest department store in Brazilian marketplaces. The analysis covers revenue trends, category performance, delivery efficiency, seller consistency, customer satisfaction, and customer segmentation using the **RFM methodology**.

---

## 🔗 Interactive Dashboard

👉 **[View on Tableau Public](https://public.tableau.com/app/profile/taufik.ibrahim/viz/OlistE-CommercePerformanceDashboard_17770780602030/OlistE-CommercePerformanceDashboard)**

---

## ❓ Business Questions

1. What are the monthly order and revenue trends?
2. Which product categories generate the highest revenue?
3. Which states have the worst delivery performance?
4. Which sellers are the most consistent performers?
5. Does delivery speed affect customer review scores?
6. How are review scores distributed across product categories?
7. Which categories have low review scores at high volume — creating the biggest risk?
8. How can customers be segmented using RFM analysis?

---

## 🗄️ Database Schema

```
orders ──────────── customers
  │
  ├── order_items ── products ── product_category_name_translation
  │        │
  │        └── sellers
  │
  ├── order_payments
  │
  └── order_reviews
```

| Table | Rows | Description |
|---|---|---|
| `orders` | 99,441 | Master order data with status and timestamps |
| `customers` | 99,441 | Customer data and location (state) |
| `order_items` | 112,650 | Item details per order — price and seller |
| `order_payments` | 103,886 | Payment data per order |
| `order_reviews` | 77,920 | Review scores and customer comments |
| `products` | 32,951 | Product data and categories |
| `sellers` | 3,095 | Seller data and location |
| `product_category_name_translation` | 71 | Portuguese → English category translation |

---

## 🗂️ Repository Structure

```
olist-sql-analysis/
├── README.md
├── queries/
│   ├── 01_monthly_trend.sql
│   ├── 02_category_performance.sql
│   ├── 03_delivery_analysis.sql
│   ├── 04_seller_performance.sql
│   ├── 05_review_score_analysis.sql
│   ├── 06_review_score_by_category.sql
│   ├── 07_category_review_filtered.sql
│   └── 08_rfm_analysis.sql
├── insights/
│   └── summary.md
└── dashboard/
```

---

## 🔧 Tools

| Tool | Purpose |
|---|---|
| **PostgreSQL 16** | Primary database & query engine |
| **DBeaver** | SQL client & data import |
| **Tableau Public** | Interactive dashboard |

---

## 💡 Key Findings & Recommendations

### 📈 1. Revenue Growth
> Revenue grew **27x in 13 months** (October 2016 → November 2017), peaking at **$1.15M** in November 2017 — likely driven by Black Friday demand.

**Recommendation:** Build a predictive model around Black Friday and year-end peaks to pre-allocate inventory and seller capacity — avoiding stockouts during the highest-value sales windows.

---

### 🛍️ 2. Category Performance
> **Health & Beauty** is the top revenue category ($1.23M). **Watches & Gifts** has the highest avg price ($199) — a premium segment. **Bed Bath Table** leads in order volume (9,272) but has a low avg price ($93) — a mass-market driver.

**Recommendation:** Bundle mass-market (high volume) products with premium categories to increase Average Order Value. Invest marketing budget in Health & Beauty to defend the top revenue position.

---

### 🚚 3. Delivery Performance
> Remote northern states have the longest delivery times — **Roraima: 29.4 days**, **Amapá: 27.2 days**. Olist consistently delivers **ahead of its own estimates** across all states — a deliberate strategy to exceed customer expectations.

**Recommendation:** Maintain the under-promise, over-deliver strategy. For remote states, partner with regional last-mile logistics providers to reduce delivery time below 20 days and improve satisfaction scores.

---

### ⭐ 4. Delivery Speed vs. Review Score
> A clear pattern emerges: **faster delivery = higher review score**.
> - ⭐⭐⭐⭐⭐ (5 stars): avg delivery **10.7 days** (+12.7 days ahead of estimate)
> - ⭐ (1 star): avg delivery **21.3 days** (+3.4 days ahead of estimate)

**Recommendation:** Set an internal SLA target of ≤12 days delivery to maximize 5-star reviews. Proactively send tracking updates for orders approaching day 15 to manage customer expectations.

---

### 🪑 5. High-Risk Category: Furniture
> Furniture categories consistently show low review scores combined with long delivery times.
> - **office_furniture**: avg review 3.49, avg delivery 20.8 days — the most critical
> - **bed_bath_table**: 7,250 orders with avg review only 3.92 — highest business impact due to volume

**Root cause:** Large, heavy products → longer delivery + higher damage risk → dissatisfied customers.

**Recommendation:** Partner with specialist large-item logistics providers for furniture. Improve packaging standards and add delivery insurance for items over a certain weight threshold.

---

### 👥 6. RFM Customer Segmentation

| Segment | Customers | Avg Recency | Avg Monetary | Priority |
|---|---|---|---|---|
| **At Risk** | 20,546 | 416 days | $225 | 🔴 High |
| **Potential Loyalist** | 20,489 | 219 days | $216 | 🟠 Medium |
| **Loyal Customer** | 10,811 | 75 days | $115 | 🟢 Retain |
| **Lost** | 10,420 | 418 days | $50 | ⚫ Low |
| **Champion** | 10,167 | 75 days | $347 | 🟢 Delight |
| **New Customer** | 9,987 | 74 days | $49 | 🟡 Nurture |

**Recommendation 1 — Winback At Risk segment:** 20,546 customers with avg spend of $225. Converting just 10% generates 2,000+ new orders. Target customers with monetary value > $200 first via personalized re-engagement campaigns.

**Recommendation 2 — Activate New Customers within 30 days:** The critical conversion window is the first 30 days after the initial order. Automated follow-up emails with a second-order discount can significantly improve long-term retention.

**Recommendation 3 — Reward Champions:** At $347 avg spend — 7x higher than New Customers — Champions deserve exclusive perks (early access, loyalty rewards) to maintain their engagement.

---

## ⚙️ How to Run

### 1. Download Dataset
Download all CSV files from Kaggle:  
👉 https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

### 2. Setup Database
```sql
CREATE DATABASE olist_analysis;
```

### 3. Create Tables & Import Data
Create all tables using the schema above, then import each CSV via DBeaver (**right-click table → Import Data**) or via psql:
```bash
psql -U postgres -d olist_analysis -c "\COPY orders FROM 'path/to/olist_orders_dataset.csv' CSV HEADER;"
```
Repeat for all 8 tables.

### 4. Run Queries
Execute queries in order from the `queries/` folder using DBeaver or any PostgreSQL client.

---

## 📜 License

Dataset sourced from Kaggle under public license. Analysis and queries by Mohammad Taufik Ibrahim.

---

## 👤 About the Author

**Mohammad Taufik Ibrahim** — Data Analyst

- 🔗 LinkedIn: [linkedin.com/in/taufikibraahim](https://www.linkedin.com/in/taufikibraahim/)
- 📊 Tableau: [public.tableau.com/app/profile/taufik.ibrahim](https://public.tableau.com/app/profile/taufik.ibrahim)
- 💻 GitHub: [github.com/taufikibraahim](https://github.com/taufikibraahim)

---

*⭐ If you found this project useful, consider leaving a star!*
