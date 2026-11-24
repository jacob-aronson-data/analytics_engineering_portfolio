import pandas as pd

def adjust_net(row):

    if row['operation'] == 'Sell':
        return row['price']
    else:
        return row['price'] * -1

def capital_gainloss(stocks: pd.DataFrame) -> pd.DataFrame:
    
    stocks['net'] = stocks.apply(adjust_net, axis = 1)

    result = stocks.groupby('stock_name').agg(stock_name = ('stock_name', 'max'), capital_gain_loss = ('net', 'sum'))

    return result
