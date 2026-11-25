import pandas as pd

def article_views(views: pd.DataFrame) -> pd.DataFrame:
    
    filtered = views[views['author_id'] == views['viewer_id']]

    result = filtered.groupby('author_id').agg(id = ('author_id', 'max'))

    return result
