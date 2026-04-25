/* 6. Review Score Analysis */
SELECT
    t.product_category_name_english     AS category,
    COUNT(DISTINCT o.order_id)          AS total_orders,
    ROUND(AVG(r.review_score)::NUMERIC, 2) AS avg_review_score,
    ROUND(AVG(
        EXTRACT(EPOCH FROM (
            o.order_delivered_customer_date -
            o.order_purchase_timestamp
        )) / 86400
    )::NUMERIC, 1)                      AS avg_delivery_days
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN order_reviews r ON oi.order_id = r.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN product_category_name_translation t
    ON p.product_category_name = t.product_category_name
WHERE o.order_status = 'delivered'
AND o.order_delivered_customer_date IS NOT NULL
GROUP BY 1
ORDER BY avg_review_score DESC;