/* 8.RFM(Recency, Frequency, Monetary) Analysis */
WITH last_order_date AS (
    SELECT MAX(order_purchase_timestamp) AS max_date
    FROM orders
    WHERE order_status = 'delivered'
),

rfm_base AS (
    SELECT
        c.customer_unique_id,
        EXTRACT(DAY FROM (
            (SELECT max_date FROM last_order_date) -
            MAX(o.order_purchase_timestamp)
        ))                                          AS recency,
        COUNT(DISTINCT o.order_id)                  AS frequency,
        ROUND(SUM(p.payment_value)::NUMERIC, 2)     AS monetary
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN order_payments p ON o.order_id = p.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY 1
),

rfm_scored AS (
    SELECT
        customer_unique_id,
        recency,
        frequency,
        monetary,
        NTILE(3) OVER (ORDER BY recency DESC)    AS r_score,
        NTILE(3) OVER (ORDER BY frequency ASC)   AS f_score,
        NTILE(3) OVER (ORDER BY monetary ASC)    AS m_score
    FROM rfm_base
),

rfm_segmented AS (
    SELECT
        customer_unique_id,
        recency,
        frequency,
        monetary,
        r_score,
        f_score,
        m_score,
        CASE
            WHEN r_score = 3 AND f_score = 3 AND m_score = 3
                THEN 'Champion'
            WHEN r_score = 3 AND f_score >= 2 AND m_score >= 2
                THEN 'Loyal Customer'
            WHEN r_score = 3 AND f_score = 1 AND m_score = 1
                THEN 'New Customer'
            WHEN r_score = 2 AND f_score >= 2 AND m_score >= 2
                THEN 'Potential Loyalist'
            WHEN r_score = 1 AND f_score >= 2 AND m_score >= 2
                THEN 'At Risk'
            WHEN r_score = 1 AND f_score = 1 AND m_score = 1
                THEN 'Lost'
            ELSE 'Others'
        END AS segment
    FROM rfm_scored
)

SELECT
    segment,
    COUNT(customer_unique_id)               AS total_customers,
    ROUND(AVG(recency)::NUMERIC, 0)         AS avg_recency_days,
    ROUND(AVG(frequency)::NUMERIC, 1)       AS avg_frequency,
    ROUND(AVG(monetary)::NUMERIC, 2)        AS avg_monetary
FROM rfm_segmented
GROUP BY 1
ORDER BY total_customers DESC;