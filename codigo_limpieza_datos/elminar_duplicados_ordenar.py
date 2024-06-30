import pandas as pd

df = pd.read_csv('NUEVOarchivo_fecha_hora_convertida.csv')

df = df.drop_duplicates(subset=['codigo_subcircuito'])

df = df.sort_values(by='codigo_subcircuito')

df = df[['codigo_subcircuito', 'nombre_zona', 'codigo_circuito']]

df.to_csv('zonaSubcircuitos.csv', index=False)

print("Datos procesados y guardados en 'archivo_sin_duplicados.csv'")
