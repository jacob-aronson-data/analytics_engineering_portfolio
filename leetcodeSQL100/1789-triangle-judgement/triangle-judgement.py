import pandas as pd

def judge(row):

    x = row['x']
    y = row['y']
    z = row['z']

    if (x + y <= z) or (x + z <= y) or (y + z <= x):
        return 'No'
    else:
        return 'Yes'

def triangle_judgement(triangle: pd.DataFrame) -> pd.DataFrame:
    
    triangle['triangle'] = triangle.apply(judge, axis = 1)

    return triangle
