with customer_spending as (
select 
c.customer_key,
sum(f.sales_amount) as total_spending,
min(order_date) as first_order,
max(order_date) as last_order,
datediff(month, min(order_date), max(order_date)) as difference_btw
from gold.fact_sales as f
left join gold.dim_customers as c
on f.customer_key = c.customer_key
group by c.customer_key
)
select 
customer_segment,
count(customer_key)as total_customers
from(
select
customer_key,
case 
when difference_btw >= 12 and total_spending > 5000 then 'vip'
when difference_btw >=12 and total_spending <= 5000 then 'regular'
else 'new'
end customer_segment
from customer_spending)t
group by customer_segment
order by total_customers   desc