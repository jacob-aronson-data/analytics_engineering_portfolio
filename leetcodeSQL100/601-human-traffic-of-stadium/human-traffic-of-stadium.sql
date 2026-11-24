# Write your MySQL query statement below

#Plan 

with leads_and_lags as(
    select *, 
        lead(people, 1) over(order by visit_date) as lead1,
        lead(people, 2) over(order by visit_date) as lead2,
        lag(people, 1) over(order by visit_date) as lag1,
        lag(people, 2) over(order by visit_date) as lag2
    from Stadium
)

select id, visit_date, people
from leads_and_lags
where (lag2 >= 100 and lag1 >= 100 and people >= 100) or
      (lag1 >= 100 and people >= 100 and lead1 >= 100) or
      (people >= 100 and lead1 >= 100 and lead2 >= 100)

