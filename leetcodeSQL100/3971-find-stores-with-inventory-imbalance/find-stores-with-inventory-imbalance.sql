# Write your MySQL query statement below

with atleast3 as (select store_id from inventory group by store_id having count(distinct inventory_id) >= 3),

store_most_exp_prework as (
    select s.store_id, 
           s.store_name, 
           s.location, 
           product_name as most_exp_product, 
           rank() over(partition by store_id order by price desc) as price_rank,
           price as expensive_price,
           quantity as expensive_quantity
    from stores s
    join inventory i
        on s.store_id = i.store_id
),

store_most_exp as (select * from store_most_exp_prework where price_rank = 1),

store_least_exp_prework as (
    select s.store_id, 
           s.store_name, 
           s.location, 
           product_name as cheapest_product, 
           rank() over(partition by store_id order by price asc) as price_rank,
           price as cheap_price,
           quantity as cheap_quantity
    from stores s
    join inventory i
        on s.store_id = i.store_id
),

store_least_exp as (select * from store_least_exp_prework where price_rank = 1),

almost as (

select m.store_id, m.store_name, m.location, most_exp_product, cheapest_product, round(cheap_quantity / expensive_quantity, 2) as imbalance_ratio
from store_most_exp m
join store_least_exp l
    on m.store_id = l.store_id
join atleast3 on m.store_id = atleast3.store_id
order by imbalance_ratio desc, store_name asc

)

select * from almost where imbalance_ratio > 1