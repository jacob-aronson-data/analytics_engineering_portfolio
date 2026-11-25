import pandas as pd

def check_primary(row):

    if row['cnt'] == 1:
        return True
    elif row['primary_flag'] == 'Y':
        return True
    else:
        return False

def find_primary_department(employee: pd.DataFrame) -> pd.DataFrame:
    
    counts = employee.groupby('employee_id').agg(id = ('employee_id', 'max'), cnt = ('employee_id', 'count'))

    joined = pd.merge(employee, counts, 'left', left_on = 'employee_id', right_on = 'id')

    joined['is_primary'] = joined.apply(check_primary, axis = 1)
    
    result = joined[joined['is_primary']][['employee_id', 'department_id']]

    return result
