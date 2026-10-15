# Write your MySQL query statement below


SELECT L1.num as ConsecutiveNums
FROM Logs L1 join Logs L2 on L1.id = L2.id + 1 join Logs L3 on L1.id = L3. id + 2
WHERE L1.num = L2.num and L2.num = L3.num and L1.num = L3.num
group by L1.num