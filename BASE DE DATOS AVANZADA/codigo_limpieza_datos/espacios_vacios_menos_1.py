import pandas as pd

def llenar_edad(csv_input, csv_output):
    df = pd.read_csv(csv_input)

    df['edad'] = df['edad'].fillna(-1)

    df.to_csv(csv_output, index=False)

csv_input = 'cleaan.csv'  
csv_output = 'cleaan_modificado.csv'

llenar_edad(csv_input, csv_output)

print(f'Archivo procesado guardado como {csv_output}')

