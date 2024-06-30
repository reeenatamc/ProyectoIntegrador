import pandas as pd

df2 = pd.read_csv('archivo_fecha_hora_convertida.csv')
df1 = pd.read_csv('archivo_principal_con_ids.csv')

df1['nac'] = df2['id_arma']

df1.to_csv('RESULTANTE.csv', index=False)
