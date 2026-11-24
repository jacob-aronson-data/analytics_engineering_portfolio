-- Write your PostgreSQL query statement below
with weather_clone as (select * from weather)


select weather.id
from weather
    full join weather_clone on weather.recordDate = weather_clone.recordDate + 1
where weather.temperature > weather_clone.temperature