import pandas as pd

def zn(val):
    return 0 if pd.isna(val) else val

def classify(row):

    if zn(row['parent']) > 0 and zn(row['child']) > 0:
        return 'Inner'
    elif zn(row['parent']) == 0 and zn(row['child']) > 0:
        return 'Root'
    elif zn(row['parent']) == 0 and zn(row['child']) == 0:
        return 'Root'
    else:
        return 'Leaf'


def tree_node(tree: pd.DataFrame) -> pd.DataFrame:

    tree2 = pd.merge(tree, tree, 'left', left_on = 'p_id', right_on = 'id')

    full = pd.merge(tree2, tree, 'left', left_on = 'id_x', right_on = 'p_id')

    agg = full.groupby('id_x').agg(id = ('id_x', 'max'), parent = ('id_y', 'max'), child = ('id', 'max'))

    agg['type'] = agg.apply(classify, axis = 1)

    return agg[['id', 'type']]
