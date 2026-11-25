import pandas as pd

def latest_login(logins: pd.DataFrame) -> pd.DataFrame:
    

    only2020 = logins[logins['time_stamp'].dt.year == 2020]

    result = only2020.groupby('user_id').agg(user_id = ('user_id', 'max'), last_stamp = ('time_stamp', 'max'))


    return result
