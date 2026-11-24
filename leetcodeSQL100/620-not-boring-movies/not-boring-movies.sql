-- Write your PostgreSQL query statement below

select *
from cinema
where id/2::int != id/2::float and description != 'boring'
order by rating desc