# Write your MySQL query statement below

with only2020 as (select * from Logins where year(time_stamp) = 2020)

select user_id, max(time_stamp) as last_stamp from only2020 group by user_id
