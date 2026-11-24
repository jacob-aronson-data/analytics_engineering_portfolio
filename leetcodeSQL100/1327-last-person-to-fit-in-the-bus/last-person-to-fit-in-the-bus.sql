# Write your MySQL query statement below

with window_agg as(

select turn, person_id, person_name, weight, SUM(weight) OVER (ORDER BY turn) AS total_weight 
from queue
order by turn

),

only_before_limit as(

select person_name, turn
from window_agg
where total_weight <=1000
)

select person_name
from only_before_limit
order by turn desc
limit 1;
