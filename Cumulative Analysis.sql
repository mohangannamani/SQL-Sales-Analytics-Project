select
order_date,
total_sales,
sum(total_sales) over(partition by order_date order by order_date) as running_total,
avg(total_sales) over(order by order_date) as moveing_average_price
from
(
select
datetrunc(year,order_date) as order_date,
sum(sales_amount) as total_sales,
avg(price) as avg_price
from gold.fact_sales
where order_date is not null
group by datetrunc(year,order_date))t