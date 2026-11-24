import pandas as pd

def count_unique_subjects(teacher: pd.DataFrame) -> pd.DataFrame:
    result = teacher.groupby('teacher_id')["subject_id"].nunique().reset_index().rename(columns = {'teacher_id':'teacher_id', 'subject_id':'cnt'})
    return result
