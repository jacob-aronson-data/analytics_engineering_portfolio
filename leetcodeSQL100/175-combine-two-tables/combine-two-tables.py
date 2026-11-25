import pandas as pd

def combine_two_tables(person: pd.DataFrame, address: pd.DataFrame) -> pd.DataFrame:
    
    result = pd.merge(person, address, 'left', left_on = 'personId', right_on = 'personId')[['firstName', 'lastName', 'city', 'state']]

    return result
