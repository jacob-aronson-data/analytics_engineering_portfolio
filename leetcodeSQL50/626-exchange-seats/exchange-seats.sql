# Write your MySQL query statement below

WITH forward AS (select s1.id, s2.student from Seat s1 join Seat s2 on s1.id = s2.id + 1),
     back AS (select s1.id, s2.student from Seat s1 join Seat s2 on s1.id = s2.id - 1)

SELECT s.id, # s.student,
        IFNULL(CASE
        WHEN s.id % 2 = 0 THEN f.student
        ELSE b.student END, s.student) as student


FROM Seat s left join forward f on s.id = f.id left join back b on s.id = b.id
order by s.id