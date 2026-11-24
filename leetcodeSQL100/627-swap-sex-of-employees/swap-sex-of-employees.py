import pandas as pd

def new_sex(row):
    if row['sex'] == 'm':
        return 'f'
    else:
        return 'm'

def swap_salary(salary: pd.DataFrame) -> pd.DataFrame:
    salary['sex'] = salary.apply(new_sex, axis = 1)
    return salary
