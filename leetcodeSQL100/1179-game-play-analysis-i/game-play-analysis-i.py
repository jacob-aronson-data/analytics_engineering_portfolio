import pandas as pd

def game_analysis(activity: pd.DataFrame) -> pd.DataFrame:
    
    result = activity.groupby('player_id').agg(player_id = ('player_id', 'max'), first_login = ('event_date', 'min'))
    
    return result
