/* 3. Delivery Performance Analysis */
select
    c.customer_state                                    AS state,
    COUNT(DISTINCT o.order_id)                          AS total_orders,
    ROUND(AVG(
        EXTRACT(EPOCH FROM (
            o.order_delivered_customer_date - 
            o.order_purchase_timestamp
        )) / 86400
    )::NUMERIC, 1)                                      AS avg_delivery_days,
    ROUND(AVG(
        EXTRACT(EPOCH FROM (
            o.order_estimated_delivery_date - 
            o.order_delivered_customer_date
        )) / 86400
    )::NUMERIC, 1)                                      AS avg_days_early_late
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
AND o.order_delivered_customer_date IS NOT NULL
GROUP BY 1
ORDER BY avg_delivery_days DESC
LIMIT 15;