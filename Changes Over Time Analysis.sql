select
datetrunc(month,order_date) as date_trunc,
sum(sales_amount) as total_sales,
count(distinct customer_key) as toal_customers,
sum(quantity) as total_quantity
from gold.fact_sales
where order_date is not null
group by datetrunc(month,order_date)
order by datetrunc(month,order_date)