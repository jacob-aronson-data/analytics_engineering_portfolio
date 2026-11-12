-- Identify parts that only appear in one LEGO set
select parts.part_num, parts.name, count(distinct inventories.set_num) as lego_sets_part_is_found_in
from inventory_parts
join parts on inventory_parts.part_num = parts.part_num
join inventories on inventory_parts.inventory_id = inventories.id
group by all
having lego_sets_part_is_found_in = 1;

-- For each LEGO set, calculate the number of unique parts it includes and the total number of parts (count, not quantity);
with cte as (
    select sets.name, sets.year, count(parts.part_num) as total_num_parts, count(distinct parts.part_num) as unique_parts
    from sets
    join inventories on sets.set_num = inventories.set_num
    join inventory_parts on inventories.id = inventory_parts.inventory_id
    full join parts on parts.part_num = inventory_parts.part_num
    group by all
)

select name, year, unique_parts / total_num_parts as uniqueness_ratio from cte;

create view sets_by_year_and_uniqueness as (

    with cte as (
        select sets.name, sets.year, count(parts.part_num) as total_num_parts, count(distinct parts.part_num) as unique_parts
        from sets
        join inventories on sets.set_num = inventories.set_num
        join inventory_parts on inventories.id = inventory_parts.inventory_id
        full join parts on parts.part_num = inventory_parts.part_num
        group by all
    )

    select name, year, unique_parts / total_num_parts as uniqueness_ratio from cte
);
