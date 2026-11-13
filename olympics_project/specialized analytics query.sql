-- Specialized Query --
-- Let's try to figure out which sports and events have parity (variation in which countries win at the event)? --


    select distinct event, sport, medal, year, team
    from fact_table f
        join dim_events de on f.event_id = de.event_id
        join dim_games dg on f.games_id = dg.games_id
        join dim_team dt on f.team_id = dt.team_id
    where medal is not null
