import pandas as pd

def employee_bonus(employee: pd.DataFrame, bonus: pd.DataFrame) -> pd.DataFrame:
    
    joined = pd.merge(employee, bonus, 'left', left_on = 'empId', right_on = 'empId')

    too_much = joined[joined['bonus'] < 1000][['name', 'bonus']]
    nulls = joined[joined['bonus'].isnull()][['name', 'bonus']]

    result = pd.concat([too_much, nulls]).sort_values('name')

    return result
