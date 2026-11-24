# Write your MySQL query statement below

#with pregroup as (select sell_date, count(product) as num_sold, group_concat(product) as products)


select sell_date, count(distinct product) as num_sold, group_concat(distinct product order by product) as products
from Activities
group by sell_date