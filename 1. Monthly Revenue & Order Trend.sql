/* 1. Monthly Revenue & Order Trend */
select
	date_trunc('month', o.order_purchase_timestamp) as month,
	count(distinct o.order_id)						as total_orders,
	round(sum(p.payment_value)::numeric,2)			as total_revenue
from orders o
join order_payments p on o.order_id = p.order_id 
where o.order_status = 'delivered'
group by 1
order by 1;