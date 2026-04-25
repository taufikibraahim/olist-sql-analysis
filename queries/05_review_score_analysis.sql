/* 5. Review Score Analysis */
select 
	r.review_score,
	count(distinct r.order_id)					as total_orders,
	round(avg(
		extract(epoch from(
			o.order_delivered_customer_date -
			o.order_purchase_timestamp
		)) / 86400
	)::numeric, 1)								as avg_delivery_days,
	round(avg(
		extract(epoch from(
			o.order_estimated_delivery_date -
			o.order_delivered_customer_date
		)) / 86400
	)::numeric, 1)								as avg_days_early_late 
from order_reviews r
join orders o on r.order_id = o.order_id
where o.order_status = 'delivered'
and o.order_delivered_customer_date is not null
group by 1
order by 1;