-- Write your PostgreSQL query statement below

select s.user_id, round(avg(CASE c.action WHEN 'confirmed' then 1 ELSE 0 end), 2) as "confirmation_rate"
from confirmations as c
    right join signups as s on c.user_id = s.user_id
group by s.user_id