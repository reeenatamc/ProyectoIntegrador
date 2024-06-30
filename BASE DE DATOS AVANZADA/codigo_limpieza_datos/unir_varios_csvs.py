import pandas as pd

urls = [
    'Trafico para consumo interno.csv',
    'Trafico para consumo interno2020.csv',
    'Trafico para consumo interno2021.csv',
    'Trafico para consumo interno2022.csv',
    'Trafico para consumo interno2023.csv'
]

dfs = []

for url in urls:
    df = pd.read_csv(url)
    dfs.append(df)

combined_df = pd.concat(dfs, ignore_index=True)

combined_df.to_csv('archivo_combinado.csv', index=False)

print('Archivo combinado guardado como archivo_combinado.csv')
