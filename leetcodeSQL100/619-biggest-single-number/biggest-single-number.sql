# Write your MySQL query statement below

WITH big_table as (

WITH num_counts AS (select num, count(num) as num_count from MyNumbers group by num)
    SELECT m.num, n.num_count
    FROM MyNumbers m join num_counts n ON m.num = n.num
    where n.num_count = 1
    group by m.num
    

)


SELECT max(num) as num from big_table