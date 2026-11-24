# Write your MySQL query statement below

with all_categories as (
    select case 
                when month(sale_date) in (12, 1, 2) then 'Winter' 
                when month(sale_date) in (3, 4, 5) then 'Spring'
                when month(sale_date) in (6, 7, 8) then 'Summer'
                else 'Fall' end as season,
            p.category,
            sum(quantity) as total_quantity,
            sum(quantity * price) as total_revenue
    from sales s
    join products p
        on s.product_id = p.product_id
    group by season, p.category
    order by season asc
),

ranked as (
    select *, rank() over(partition by season order by total_quantity desc, total_revenue desc) as rnk
    from all_categories)

select season, category, total_quantity, total_revenue from ranked where rnk = 1