# Write your MySQL query statement below

with total_products as (select count(distinct product_key) as num from Product),
products_per_customer as (select customer_id, count(distinct product_key) as num from Customer group by customer_id)


select p.customer_id
from products_per_customer p join total_products t on 1=1 where p.num = t.num