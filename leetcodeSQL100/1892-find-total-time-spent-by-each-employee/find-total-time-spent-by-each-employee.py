import pandas as pd

def total_time(employees: pd.DataFrame) -> pd.DataFrame:
    
    employees['total_time'] = employees['out_time'] - employees['in_time']

    result = employees.groupby(['event_day', 'emp_id']).agg(day = ('event_day', 'max'), emp_id = ('emp_id', 'max'), total_time = ('total_time', 'sum'))

    return result
