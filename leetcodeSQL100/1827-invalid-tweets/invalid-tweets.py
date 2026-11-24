import pandas as pd

def invalid_tweets(tweets: pd.DataFrame) -> pd.DataFrame:
    
    tweets['len'] = tweets['content'].str.len()

    result = tweets[tweets['len'] > 15][['tweet_id']]

    return result
