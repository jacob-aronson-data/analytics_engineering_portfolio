-- Write your PostgreSQL query statement below
-- with subjects_and_examinations as ()

with all_students_and_subjects as (select * from students cross join subjects)

select a.student_id, a.student_name, a.subject_name, count(e.subject_name) as "attended_exams"
from examinations as e
    right join all_students_and_subjects as a on e.student_id = a.student_id and a.subject_name = e.subject_name
group by a.student_id, a.student_name, a.subject_name
order by a.student_id, a.subject_name

--full outer join examinations as e on st.student_id = e.student_id
--full outer join subjects on subjects.subject_name = e.subject_name
--full outer join all_students_and_subjects as a on st.student_id = a.student_id and subjects.subject_name = a.subject_name