# Write your MySQL query statement below

with feb_totals as (
    select product_id, sum(unit) as unit
    from Orders
    where order_date > '2020-01-31' and order_date < '2020-03-01'
    group by product_id
)

select p.product_name, f.unit
from Products p join feb_totals f on p.product_id = f.product_id
where f.unit >= 100