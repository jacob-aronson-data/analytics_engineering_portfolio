-- Write your PostgreSQL query statement below

select p.project_id, ROUND(avg(experience_years), 2) as "average_years"
from project as p
    right join employee as e on p.employee_id = e.employee_id
where not p.project_id is null
group by p.project_id
