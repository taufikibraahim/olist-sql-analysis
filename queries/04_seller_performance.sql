/* 4. Seller Performance */
select
	oi.seller_id,
	s.seller_state,
	count(distinct oi.order_id)				as total_orders,
	round(sum(oi.price)::numeric, 2)		as total_revenue,
	round(avg(oi.price)::numeric, 2)		as avg_price,
	round(avg(r.review_score)::numeric, 2)	as avg_review_score
from order_items oi
join orders o on oi.order_id = o.order_id
join sellers s on oi.seller_id = s.seller_id 
join order_reviews r on o.order_id = r.order_id 
where o.order_status = 'delivered'
group by 1, 2
having count(oi.order_id ) >= 100
order by total_revenue desc
limit 15;