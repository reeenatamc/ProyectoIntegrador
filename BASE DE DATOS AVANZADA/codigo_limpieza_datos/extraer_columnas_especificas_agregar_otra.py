import pandas as pd

def extraer_columnas_especificas(csv_input, csv_output):
    df = pd.read_csv(csv_input)

    columnas = [
        'edad', 'sexo', 'genero', 'estado_civil', 'nivel_de_instruccion', 
        'estatus_migratorio', 'numero_detenciones', 'autoidentificacion_etnica', 'codigo_iccs', 'nacionalidad'
    ]
    df_seleccionado = df[columnas]

    df_seleccionado['nacionalidadid'] = 1

    df_seleccionado.to_csv(csv_output, index=False, encoding='utf-8', sep=',')

csv_input = 'cleaan_modificado2.csv'  
csv_output = 'detenido1.csv'  

extraer_columnas_especificas(csv_input, csv_output)

print(f'Archivo con las columnas seleccionadas guardado como {csv_output}')
