/* 2. Category Performance */
select
	t.product_category_name_english 			as category,
	count(distinct o.order_id)					as total_orders,
	round(sum(oi.price)::numeric, 2) 			as total_revenue,
	round(avg(oi.price)::numeric, 2) 			as avg_order_value,
	round(avg(oi.freight_value)::numeric, 2) 	as avg_freight
from order_items oi
join orders o on oi.order_id = o.order_id
join products p on oi.product_id = p.product_id
join product_category_name_translation t 
	on p.product_category_name = t.product_category_name
where o.order_status = 'delivered'
group by 1
order by total_revenue desc
limit 10;