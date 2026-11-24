import pandas as pd

def check_start(row):
    if row['dna_sequence'].startswith('ATG'):
        return 1
    else:
        return 0

def check_end(row):
    if row['dna_sequence'].endswith('TAA') or row['dna_sequence'].endswith('TAG') or row['dna_sequence'].endswith('TGA'):
        return 1       
    else:
        return 0

def check_atat(row):
    if 'ATAT' in row['dna_sequence']:
        return 1       
    else:
        return 0

def check_ggg(row):
    if 'GGG' in row['dna_sequence']:
        return 1       
    else:
        return 0 

def analyze_dna_patterns(samples: pd.DataFrame) -> pd.DataFrame:
    
    samples['has_start'] = samples.apply(check_start, axis = 1)
    samples['has_stop'] = samples.apply(check_end, axis = 1)
    samples['has_atat'] = samples.apply(check_atat, axis = 1)
    samples['has_ggg'] = samples.apply(check_ggg, axis = 1)

    return samples
