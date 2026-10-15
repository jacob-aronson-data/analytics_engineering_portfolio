with preagg as (select visited_on, sum(amount) as amount from Customer group by visited_on),


 first as (

SELECT 
    visited_on,
    sum(amount) OVER (
        ORDER BY visited_on 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS amount,
    round(AVG(amount) OVER (
        ORDER BY visited_on 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ), 2) AS average_amount
FROM preagg
)

select f.* from first f join first f2 on f.visited_on = date_add(f2.visited_on, INTERVAL 6 DAY)