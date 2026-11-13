-- Specialized Query --
-- Let's try to figure out which sports and events have parity (variation in which names / countries win at the event)? --

with select_fields as (
    select event, sport, medal, name, year, team
    from fact_table f
        join dim_events de on f.event_id = de.event_id
        join dim_athletes da on f.athlete_id = da.athlete_id
        join dim_games dg on f.games_id = dg.games_id
        join dim_team dt on f.team_id = dt.team_id
    where medal is not null
)

select event, sport, medal,
       count(*) as total_medals,
       count(distinct name) as distinct_medal_winning_names,
       count(distinct team) as distinct_medal_winning_teams
       
from select_fields
group by all
