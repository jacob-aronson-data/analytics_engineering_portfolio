# Write your MySQL query statement below

with u as (

select product_id, 'store1' as store, store1 as price from Products

union all

select product_id, 'store2' as store, store2 as price from Products

union all

select product_id, 'store3' as store, store3 as price from Products

)

select * from u where price is not null order by product_id asc
