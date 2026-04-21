# 🛒 Olist E-Commerce — SQL Analysis

**Analyst:** Mohammad Taufik Ibrahim
**Date:** April 2026
**Dataset:** [Brazilian E-Commerce Public Dataset by Olist (Kaggle)](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
**Tools:** PostgreSQL · DBeaver

---

## 📌 Project Overview

This project analyzes 2 years of transactional data (October 2016 – August 2018) from Olist, the largest department store in Brazilian marketplaces. The analysis covers revenue trends, category performance, delivery efficiency, seller consistency, customer satisfaction, and customer segmentation using RFM methodology.

---

## ❓ Business Questions

1. Bagaimana tren order dan revenue per bulan?
2. Kategori produk mana yang menghasilkan revenue tertinggi?
3. State mana yang memiliki performa pengiriman terburuk?
4. Seller mana yang paling konsisten performanya?
5. Apakah kecepatan pengiriman mempengaruhi review score?
6. Bagaimana distribusi review score per kategori produk?
7. Kategori mana yang memiliki review score rendah dengan volume tinggi?
8. Bagaimana segmentasi customer berdasarkan RFM?

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
|-------|------|-------------|
| orders | 99.441 | Master order data dengan status dan timestamp |
| customers | 99.441 | Data customer dan lokasi (state) |
| order_items | 112.650 | Detail item per order — harga dan seller |
| order_payments | 103.886 | Data pembayaran per order |
| order_reviews | 77.920 | Review score dan komentar customer |
| products | 32.951 | Data produk dan kategori |
| sellers | 3.095 | Data seller dan lokasi |
| product_category_name_translation | 71 | Terjemahan kategori Portugis → Inggris |

---

## 🔍 Key Findings

### 📈 Revenue Trend
- Revenue tumbuh **27x lipat** dalam 13 bulan (Oktober 2016 → November 2017)
- Puncak tertinggi di **November 2017** — 7.289 orders, revenue **$1.15 juta** (kemungkinan Black Friday effect)

### 🛍️ Category Performance
- **Health & Beauty** adalah kategori revenue tertinggi ($1.23M)
- **Watches & Gifts** memiliki avg price tertinggi ($199) — kategori premium
- **Bed Bath Table** order terbanyak (9.272) tapi avg price terendah ($93) — mass market

### 🚚 Delivery Performance
- State terpencil di utara Brazil memiliki delivery time terlama — **RR: 29.4 hari**, **AP: 27.2 hari**
- Olist secara konsisten deliver **lebih cepat dari estimasi** di semua state — strategi yang disengaja untuk meningkatkan kepuasan customer

### ⭐ Review Score vs Delivery
- Pola sangat jelas: **semakin cepat pengiriman → semakin tinggi review score**
- Review bintang 5: avg delivery **10.7 hari** (+12.7 hari lebih cepat dari estimasi)
- Review bintang 1: avg delivery **21.3 hari** (+3.4 hari lebih cepat dari estimasi)

### 🪑 Category Review Analysis
- Kategori **furniture** secara konsisten memiliki review rendah dan delivery lama
- **office_furniture**: review 3.49, delivery 20.8 hari — paling kritis
- **bed_bath_table**: 7.250 orders dengan review hanya 3.92 — dampak terbesar karena volume tinggi
- **Root cause:** Produk besar dan berat → delivery lama + risiko kerusakan → customer kecewa

### 👥 RFM Segmentation

| Segment | Customers | Avg Recency | Avg Monetary |
|---------|-----------|-------------|--------------|
| At Risk | 20.546 | 416 hari | $225 |
| Potential Loyalist | 20.489 | 219 hari | $216 |
| Loyal Customer | 10.811 | 75 hari | $115 |
| Lost | 10.420 | 418 hari | $50 |
| Champion | 10.167 | 75 hari | $347 |
| New Customer | 9.987 | 74 hari | $49 |

- **At Risk** adalah segment terbesar (20.546 customers) — potensi revenue recovery terbesar
- **Champion** memiliki avg monetary tertinggi ($347) — 7x lipat dibanding New Customer

---

## 🎯 Recommendations

### 1. Perbaiki Distribusi Kategori Furniture
Bermitra dengan jasa logistik spesialis barang besar untuk kategori furniture — saat ini distribusi adalah bottleneck utama yang menekan review score dan repeat order.

### 2. Winback Campaign untuk At Risk Segment
20.546 customers dengan avg monetary $225 — konversi 10% saja menghasilkan 2.000+ orders baru. Prioritaskan yang monetary > $200.

### 3. Aktifkan Repeat Purchase untuk New Customer dalam 30 Hari
Window kritis konversi adalah 30 hari pertama setelah order pertama. Automated follow-up email dengan diskon order kedua dapat meningkatkan retention rate secara signifikan.

### 4. Transparansi Estimasi Pengiriman untuk State Terpencil
State RR, AP, AM memiliki delivery 26–29 hari. Tampilkan estimasi yang akurat dan pertimbangkan partnership dengan logistik lokal untuk mempercepat last-mile delivery.

---

## 📁 Repository Structure

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
└── insights/
    └── summary.md
```

---

## ⚙️ How to Run

### 1. Download Dataset
Download semua file CSV dari Kaggle:
👉 https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

### 2. Setup Database
```sql
CREATE DATABASE olist_analysis;
```

### 3. Create Tables & Import Data
Buat semua tabel menggunakan schema di atas, lalu import setiap CSV ke tabel yang sesuai via DBeaver (**klik kanan tabel → Import Data**) atau via psql:
```bash
psql -U postgres -d olist_analysis -c "\COPY orders FROM 'path/to/olist_orders_dataset.csv' CSV HEADER;"
```
Ulangi untuk semua 8 tabel.

### 4. Run Queries
Jalankan query secara berurutan dari folder `queries/` menggunakan DBeaver atau tools PostgreSQL lainnya.

---

## 📜 License
Dataset sourced from Kaggle under public license. Analysis and queries by Mohammad Taufik Ibrahim.
