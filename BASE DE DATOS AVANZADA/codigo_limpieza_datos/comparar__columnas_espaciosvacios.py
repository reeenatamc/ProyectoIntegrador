import pandas as pd

df_principal = pd.read_csv('NUEVOarchivo_fecha_hora_convertida.csv')
df_zonas = pd.read_csv('zonaSubcircuitos.csv')

zona_a_subcircuito = pd.Series(df_zonas.codigo_subcircuito.values, index=df_zonas.nombre_zona).to_dict()

def llenar_codigo_subcircuito(row):
    if pd.isna(row['codigo_subcircuito']):
        return zona_a_subcircuito.get(row['nombre_zona'], -1)
    return row['codigo_subcircuito']

df_principal['codigo_subcircuito'] = df_principal.apply(llenar_codigo_subcircuito, axis=1)

df_principal.to_csv('NUEVOsubcircuitos.csv', index=False)


import pandas as pd

df_principal = pd.read_csv('NUEVOarchivo_fecha_hora_convertida.csv')
df_zonas = pd.read_csv('zonaSubcircuitos.csv')

zona_a_subcircuito = pd.Series(df_zonas.codigo_subcircuito.values, index=df_zonas.nombre_zona).to_dict()

def llenar_codigo_subcircuito(row):
    if pd.isna(row['codigo_subcircuito']) or row['codigo_subcircuito'] == '':
        return zona_a_subcircuito.get(row['nombre_zona'], -1)
    return row['codigo_subcircuito']

df_principal['codigo_subcircuito'] = df_principal.apply(llenar_codigo_subcircuito, axis=1)

df_principal.to_csv('archivo_principal_con_subcircuitos.csv', index=False)


