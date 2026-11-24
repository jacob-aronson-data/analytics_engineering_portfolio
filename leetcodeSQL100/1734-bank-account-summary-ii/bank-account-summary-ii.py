import pandas as pd

def account_summary(users: pd.DataFrame, transactions: pd.DataFrame) -> pd.DataFrame:
    
    joined = pd.merge(users, transactions, 'inner', left_on = 'account', right_on = 'account')

    grouped = joined.groupby('name').agg(name = ('name', 'max'), balance = ('amount', 'sum'))

    filtered = grouped[grouped['balance'] > 10000]

    return filtered
