import pandas as pd

def replace_employee_id(employees: pd.DataFrame, employee_uni: pd.DataFrame) -> pd.DataFrame:
    
    joined = pd.merge(employees, employee_uni, 'left', left_on = 'id', right_on = 'id')[['unique_id', 'name']]

    return joined
