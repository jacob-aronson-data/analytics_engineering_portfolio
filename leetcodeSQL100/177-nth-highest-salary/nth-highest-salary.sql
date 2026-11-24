CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      # Write your MySQL query statement below.

      select max(salary) from (select *, rank() over(order by salary desc) as salrank from Employee group by salary) cte where salrank = N group by salary

  );
END
