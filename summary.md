# Olist E-Commerce — Analysis Summary

**Analyst:** Mohammad Taufik Ibrahim
**Dataset:** Brazilian E-Commerce Public Dataset by Olist (Kaggle)
**Period:** October 2016 – August 2018
**Tools:** PostgreSQL, DBeaver

---

## Business Questions

1. Bagaimana tren order dan revenue per bulan?
2. Kategori produk mana yang menghasilkan revenue tertinggi?
3. State mana yang memiliki performa pengiriman terburuk?
4. Seller mana yang paling konsisten performanya?
5. Apakah kecepatan pengiriman mempengaruhi review score?
6. Bagaimana distribusi review score per kategori produk?
7. Kategori mana yang memiliki review score rendah dengan volume tinggi?
8. Bagaimana segmentasi customer berdasarkan RFM?

---

## Key Findings

### 1. Monthly Revenue & Order Trend
- Revenue dan order tumbuh konsisten dari Oktober 2016 hingga puncaknya di **November 2017** dengan 7.289 orders dan revenue **$1.15 juta** — kemungkinan driven by Black Friday
- Growth **27x lipat** dalam 13 bulan (Oktober 2016 → November 2017)
- Data 2018 tidak lengkap (hanya sampai Agustus) sehingga tidak bisa dibandingkan secara apple-to-apple dengan 2017
- **Red flag:** Perlu investigasi lebih lanjut apakah pertumbuhan revenue diikuti pertumbuhan profitabilitas

---

### 2. Category Performance
- **Health & Beauty** adalah kategori dengan revenue tertinggi ($1.23M, 8.647 orders)
- **Watches & Gifts** memiliki avg price tertinggi ($199) — kategori premium, low volume
- **Bed Bath Table** memiliki order terbanyak (9.272) tapi avg price paling rendah ($93) — kategori mass market
- **Auto** dan **Furniture Decor** memiliki avg freight tertinggi ($21–22) yang berpotensi menghambat konversi

---

### 3. Delivery Performance by State
- State di wilayah Amazon/utara Brazil memiliki delivery time terlama:
  - **RR (Roraima):** 29.4 hari rata-rata
  - **AP (Amapá):** 27.2 hari
  - **AM (Amazonas):** 26.4 hari
- Semua state memiliki `avg_days_early_late` positif — artinya Olist secara konsisten deliver **lebih cepat dari estimasi**, strategi yang disengaja untuk meningkatkan kepuasan customer
- **BA (Bahia)** dengan 3.256 orders dan 19.3 hari delivery perlu perhatian karena volumenya besar

---

### 4. Seller Performance
- **Dominasi SP (São Paulo):** 12 dari 15 top seller berasal dari SP — pusat ekonomi dan logistik Brazil
- Top seller by revenue juga konsisten memiliki review score tinggi (>3.8) — performa tinggi berkorelasi dengan kepuasan customer
- Seller dari BA dengan avg price $540 (hampir 5x rata-rata) mengindikasikan segmen produk premium
- Seller dengan order terbanyak (1.423 orders) justru memiliki avg price terendah ($61) — strategi mass market, high volume

---

### 5. Review Score vs Delivery Time
- Pola sangat jelas: **semakin cepat pengiriman → semakin tinggi review score**

| Review Score | Avg Delivery Days | Tiba Lebih Cepat dari Estimasi |
|-------------|-------------------|-------------------------------|
| ⭐ 1 | 21.3 hari | +3.4 hari |
| ⭐⭐ 2 | 16.4 hari | +8.0 hari |
| ⭐⭐⭐ 3 | 14.3 hari | +10.2 hari |
| ⭐⭐⭐⭐ 4 | 12.3 hari | +11.7 hari |
| ⭐⭐⭐⭐⭐ 5 | 10.7 hari | +12.7 hari |

- Customer dengan review bintang 1 tetap menerima barang lebih cepat dari estimasi, namun gap-nya sangat kecil (+3.4 hari) dibanding bintang 5 (+12.7 hari)
- **Kesimpulan:** Kecepatan pengiriman adalah driver utama kepuasan customer di platform Olist

---

### 6. Review Score by Category
- Tanpa filter volume, kategori dengan review score tertinggi adalah kategori kecil seperti **fashion_childrens_clothes** (score 5.0, hanya 6 orders) — tidak representatif
- Pola umum: kategori dengan delivery cepat (<12 hari) cenderung memiliki review score di atas 4.0
- Kategori dengan delivery lambat (>15 hari) hampir selalu memiliki review di bawah 4.0

---

### 7. Category Review Analysis (Volume ≥ 500)
- Kategori **furniture** secara konsisten memiliki review rendah dan delivery lama:

| Category | Orders | Avg Review | Avg Delivery |
|----------|--------|------------|--------------|
| office_furniture | 986 | 3.49 | 20.8 hari |
| bed_bath_table | 7.250 | 3.92 | 12.9 hari |
| furniture_decor | 4.857 | 3.94 | 12.8 hari |

- **bed_bath_table** adalah kategori paling kritis — volume terbesar (7.250 orders) dengan review hanya 3.92
- **Root cause:** Produk besar dan berat → delivery lebih lama + risiko kerusakan saat pengiriman lebih tinggi → customer kecewa
- Kategori terbaik: **luggage_accessories** (review 4.36, delivery 10.5 hari)

---

### 8. RFM Customer Segmentation

| Segment | Total Customers | Avg Recency | Avg Monetary |
|---------|----------------|-------------|--------------|
| At Risk | 20.546 | 416 hari | $225 |
| Potential Loyalist | 20.489 | 219 hari | $216 |
| Others | 10.937 | 220 hari | $51 |
| Loyal Customer | 10.811 | 75 hari | $115 |
| Lost | 10.420 | 418 hari | $50 |
| Champion | 10.167 | 75 hari | $347 |
| New Customer | 9.987 | 74 hari | $49 |

- **At Risk** adalah segment terbesar (20.546 customers) dengan avg recency 416 hari — lebih dari 1 tahun tidak belanja
- **Champion** memiliki avg monetary tertinggi ($347) — 3x lipat dibanding New Customer ($49)
- Mayoritas customer memiliki frequency = 1 — Olist didominasi one-time buyer, repeat purchase adalah tantangan utama platform

---

## Recommendations

### 1. Perbaiki Distribusi Kategori Furniture
Olist perlu bermitra dengan jasa logistik spesialis barang besar untuk kategori furniture. Saat ini distribusi menjadi bottleneck utama yang menekan review score dan berpotensi menurunkan repeat order dari 20.000+ pembeli furniture.

### 2. Implementasi Winback Campaign untuk At Risk Segment
Dengan 20.546 customers di segment At Risk dan avg monetary $225, potensi revenue recovery sangat besar. Bahkan konversi 10% saja menghasilkan 2.000+ orders baru. Prioritaskan At Risk dengan monetary > $200.

### 3. Aktifkan Repeat Purchase untuk New Customer dalam 30 Hari
Window kritis konversi one-time buyer menjadi loyal customer adalah 30 hari pertama. Implementasi automated follow-up email dengan diskon order kedua dapat secara signifikan meningkatkan retention rate.

### 4. Tetapkan Hard Cap Pengiriman untuk State Terpencil
State seperti RR, AP, dan AM memiliki delivery time 26–29 hari. Olist perlu transparan dengan customer di state ini — tampilkan estimasi yang akurat dan pertimbangkan partnership dengan logistik lokal untuk mempercepat last-mile delivery.

---

## Files

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
