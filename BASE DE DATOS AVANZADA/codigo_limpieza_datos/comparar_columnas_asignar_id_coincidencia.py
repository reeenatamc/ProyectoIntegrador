import pandas as pd

df_principal = pd.read_csv('archivo_fecha_hora_convertida.csv')
df_arma = pd.read_csv('ARMAS.csv')

arma_a_id = pd.Series(df_arma.id_arma.values, index=df_arma.arma).to_dict()

df_principal['id_arma'] = df_principal['arma'].map(arma_a_id)

df_principal.to_csv('archivo_principal_con_ids.csv', index=False)
