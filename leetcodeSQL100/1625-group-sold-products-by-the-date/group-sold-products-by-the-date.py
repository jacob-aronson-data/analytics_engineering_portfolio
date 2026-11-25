import pandas as pd

def categorize_products(activities: pd.DataFrame) -> pd.DataFrame:
    
    activities = activities.sort_values(by = 'product')

    products = activities.groupby(['sell_date', 'product']).agg(dateee = ('sell_date', 'max'), products = ('product', 'max'))

    totals = products.groupby(['dateee']).agg(
                                                        sell_date = ('dateee', 'max'), 
                                                        num_sold = ('products', 'nunique'),
                                                        products = ('products', lambda x : ','.join(x)))

    return totals
