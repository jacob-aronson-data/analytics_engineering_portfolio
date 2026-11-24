# Write your MySQL query statement below

with sequence as (
    select session_id, student_id, subject, hours_studied,
            datediff(session_date, lag(session_date) over(partition by student_id order by session_id)) as days_past,
            lead(subject, 3) over (partition by student_id order by session_id) lead3,
            lead(subject, 4) over (partition by student_id order by session_id) lead4,
            lead(subject, 5) over (partition by student_id order by session_id) lead5,
            lead(subject, 6) over (partition by student_id order by session_id) lead6,
            lead(subject, 1) over (partition by student_id order by session_id) lead1
    from study_sessions
    order by student_id, session_id, subject
)


select sequence.student_id, students.student_name, students.major,
       case when sum(case when subject = lead3 then 1 else 0 end) >= 3 then 3
            when sum(case when subject = lead4 then 1 else 0 end) >= 4 then 4
            when sum(case when subject = lead5 then 1 else 0 end) >= 5 then 5
            when sum(case when subject = lead6 then 1 else 0 end) >= 6 then 6
            else null end as cycle_length,
        sum(hours_studied) as total_study_hours
from sequence
join students 
    on sequence.student_id = students.student_id
group by sequence.student_id
having cycle_length is not null and 
       max(days_past) <= 2 and
       max(subject = lead1) = false
order by cycle_length desc, total_study_hours desc