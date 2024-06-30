import pandas as pd

nacionalidades = [
    'ECUATORIANO', 'PERUANO', 'COLOMBIANO', 'ARGENTINO', 'BRASILEÑO', 'CHILENO', 
    'URUGUAYO', 'PARAGUAYO', 'VENEZOLANO', 'BOLIVIANO', 'MEXICANO', 'CUBANO', 
    'DOMINICANO', 'ESPAÑOL', 'ITALIANO', 'FRANCÉS', 'ALEMÁN', 'INGLÉS', 'PORTUGUÉS', 
    'CHINO', 'BRITÁNICO', 'TAIWANÉS', 'ECUATOGUINEANO', 'GUATEMALTECO', 'CROATA', 
    'BIELORRUSO', 'LIBANÉS', 'ESTADOUNIDENSE', 'KIRGUÍS', 'ALBANO', 'SERBIO', 
    'GEORGIANO', 'INDIO/HINDÚ', 'HAITIANO', 'GRIEGO', 'NIGERIANO', 'CANADIENSE', 
    'AUSTRALIANO', 'RUSO', 'RUMANO', 'PALAUANO', 'ISRAELÍ', 'ESTONIO', 
    'VANUATUENSE', 'PANAMEÑO', 'UGANDÉS', 'MACEDONIO', 'CABOVERDIANO', 'SUDAFRICANO', 
    'CAMERUNÉS', 'IRANÍ', 'PAPÚ', 'LETONIO', 'TURCO', 'PAKISTANÍ', 'UCRANIANO', 
    'NICARAGUENSE', 'SUECO', 'LITUANO', 'ETÍOPE', 'MALTES', 'CHINA', 'MALASIO', 
    'HONDUREÑO', 'INDIO', 'POLACO', 'AUSTRIACO', 'SAMOANO', 'BUTANÉS', 'INDONESIO', 
    'SIERRA LEONÉS', 'SRI LANKÉS', 'EGIPCIO', 'JAPONÉS', 'SIRIO', 'PALESTINO', 
    'VIETNAMITA', 'BELGA', 'YEMENÍ', 'SALVADOREÑO', 'SUIZO', 'NEOZELANDÉS', 
    'COSTARRICENSE', 'BANGLADESÍ', 'VATICANO', 'ARGELINO', 'GUINEANO', 
    'RUMANO', 'CAMERUNÉS', 'LIBANESA', 'NIGERIANA', 'SALVADOREÑA', 
    'INDÚ', 'AUSTRALIANA', 'ARMENIO', 'UCRANIANA', 'BOLIVIANA', 'JORDANA', 
    'AZERBAIJANO', 'SIRIA', 'MARROQUÍ', 'BÚLGARA', 'HONDUREÑA', 
    'BARBADENSE', 'AFRICANA', 'YUGOSLAVA', 'MARFILEÑA', 'PAKISTANÍ', 
    'COREANA', 'FILIPINO', 'COMORENSE', 'CONGOLEÑO', 'DANÉS', 'MALAYO', 
    'SINGAPURENSE', 'SURCOREANO', 'NIGERINO', 'SALOMONENSE', 'HOLANDÉS', 
    'CROATA', 'ESLOVACO', 'SENEGALES', 'UZBECO', 
    'CHADIANO', 'TAYIKO', 'MOLDAVO', 'BISAUNGINEANO', 'IRLANDÉS', 
    'CAMBOYANO', 'CEILANDÉS', 'NORUEGO', 'LIBIO', 'GHANÉS'
]

def extraer_nacionalidades_unicas(csv_input, csv_output):
    df = pd.read_csv(csv_input)

    df_nacionalidades = df[df['nacionalidad'].isin(nacionalidades)].drop_duplicates(subset=['nacionalidad']).reset_index(drop=True)

    df_nacionalidades_final = pd.DataFrame({
        'ID': range(1, len(df_nacionalidades) + 1),
        'nacionalidad': df_nacionalidades['nacionalidad']
    })

    df_nacionalidades_final.to_csv(csv_output, index=False, encoding='utf-8', sep=',')

csv_input = 'cleaan_modificado2.csv'  
csv_output = 'nacionalidades_unicas.csv'  

extraer_nacionalidades_unicas(csv_input, csv_output)

print(f'Archivo con nacionalidades únicas guardado como {csv_output}')
