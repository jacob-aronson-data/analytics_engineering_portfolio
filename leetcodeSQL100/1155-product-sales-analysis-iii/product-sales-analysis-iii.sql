# Write your MySQL query statement below

select s.product_id, m.first_year, s.quantity, s.price
from Sales s join (select product_id, min(year) as first_year from Sales group by product_id) m
on s.product_id = m.product_id
where s.year = m.first_year