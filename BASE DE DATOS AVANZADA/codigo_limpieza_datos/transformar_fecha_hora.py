import pandas as pd
from datetime import datetime

def convertir_fecha(fecha):
    try:
        fecha = str(fecha)
        fecha_dt = datetime.strptime(fecha, '%Y-%m-%dT%H:%M:%S.%f%z')
        return fecha_dt.strftime('%Y-%m-%d')
    except ValueError:
        return fecha  
def convertir_hora(fecha):
    try:
        fecha = str(fecha)
        fecha_dt = datetime.strptime(fecha, '%Y-%m-%dT%H:%M:%S.%f%z')
        return fecha_dt.strftime('%H:%M:%S')
    except ValueError:
        return fecha  

df = pd.read_csv('RESULTANTE.csv', low_memory=False)

df['fecha_detencion_aprehension'] = df['fecha_detencion_aprehension'].apply(convertir_fecha)

df['hora_detencion_aprehension'] = df['hora_detencion_aprehension'].apply(convertir_hora)

df['nueva_columna'] = 1

df.to_csv('NUEVOarchivo_fecha_hora_convertida.csv', index=False)

print("Fechas, horas convertidas y nueva columna agregada. Guardado en 'archivo_fecha_hora_convertida.csv'")
