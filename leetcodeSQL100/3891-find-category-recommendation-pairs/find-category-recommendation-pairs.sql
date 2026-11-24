# Write your MySQL query statement below

with product_combinations as (
    select p1.category as category1, p2.category as category2
    from ProductInfo p1
    join ProductInfo p2
    where p1.category < p2.category
    group by p1.product_id, p2.product_id
),

user_products as (
    select user_id, group_concat(distinct category separator ', ') as product_list, count(quantity) as cnt 
    from ProductPurchases 
    join ProductInfo
        on ProductPurchases.product_id = ProductInfo.product_id
    group by user_id
),

joined as (
    select * from product_combinations
    left join user_products
    on product_list like concat('%', category1, '%') and product_list like concat('%', category2, '%')
)

select category1, category2, count(distinct user_id) as customer_count 
from joined 
where category1 != category2 
group by category1, category2
having customer_count >= 3 
order by customer_count desc, category1 asc, category2 asc