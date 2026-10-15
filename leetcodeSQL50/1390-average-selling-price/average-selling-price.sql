-- Write your PostgreSQL query statement below


select Prices.product_id, IFNULL(ROUND(sum(units * price) / sum(units), 2), 0) as "average_price"
from UnitsSold
    right join Prices on UnitsSold.product_id = Prices.product_id 
        and purchase_date between start_date and end_date
group by Prices.product_id