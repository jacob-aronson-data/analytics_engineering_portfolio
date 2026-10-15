with befores as 
    (select product_id, max(change_date) as max_date from Products where change_date <= '2019-08-16' group by product_id),

afters as 
    (select product_id, max(change_date) as max_date from Products where change_date > '2019-08-16' group by product_id),

combined as 
    (select * from befores
    UNION ALL
    select * from afters),

combined2 as (select product_id, min(max_date) as test from combined group by product_id)

select p.product_id, CASE WHEN c.test <= '2019-08-16' THEN p.new_price ELSE 10 END as price
from Products p join combined2 c on p.product_id = c.product_id and p.change_date = c.test