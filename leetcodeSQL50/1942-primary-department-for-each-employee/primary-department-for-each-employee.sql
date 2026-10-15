# Write your MySQL query statement below

WITH solos as (select employee_id, 
                      department_id
                       from Employee
                       group by employee_id
                       having count(department_id) = 1),

non_solos as (select employee_id, 
                    department_id
                    FROM Employee 
                    WHERE primary_flag = 'Y')


select * from solos UNION ALL select * from non_solos