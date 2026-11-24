# Write your MySQL query statement below

WITH students_per_class as (select count(distinct student) as student_count, class from Courses group by class)

select c.class
from Courses c join students_per_class s on c.class = s.class
where s.student_count >=5
group by c.class