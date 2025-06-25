from deep_translator import GoogleTranslator, exceptions
from pathlib import Path
from time import sleep
import unicodedata
import random
execution_path = Path(__file__).parent.absolute()
script_file_path = Path(execution_path, 'script.sql')

details = [
    "Cambio de aceite y filtro", "Reemplazo de frenos", "Alineación y balanceo",
    "Revisión de suspensión", "Cambio de batería", "Reparación de transmisión",
    "Inspección de sistema eléctrico", "Reemplazo de bujías", "Revisión de sistema de refrigeración",
    "Mantenimiento de sistema de escape", "Reemplazo de correa de distribución",
    "Revisión de sistema de dirección", "Cambio de líquido de frenos",
    "Reemplazo de filtro de aire", "Revisión de sistema de combustible",
    "Inspección de neumáticos", "Reemplazo de amortiguadores", "Revisión de luces y señales",
    "Reparación de sistema de escape", "Mantenimiento de sistema de climatización"
]

languages = ['es', 'en', 'fr', 'ar', 'zh-CN', 'ru']


with open(file=script_file_path, mode='w', encoding='utf-8') as script_file:
    limit = 15_000
    index = 0

    while True:
        if index == limit:
            break

        index+=1
        order_id = random.randint(a=1, b=15_001)
        client_id = random.randint(a=1, b=15_001)
        code_language = random.choice(seq=languages)
        original_text = random.choice(seq=details)
        original_text = unicodedata.normalize('NFKD', original_text)


        # se maneja la excepción de TooManyRequests
        # en caso de que se sature la API a la cual
        # se consulta para la traducción

        # Server Error: You made too many requests to the server.According to google, 
        # you are allowed to make 5 requests per secondand up to 200k requests per day.
        # You can wait and try again later oryou can try the translate_batch function
        try:
            translated_text = (GoogleTranslator(source='es', target=code_language).translate(text=original_text) if code_language != 'es' else original_text).replace("'", "''")
        except exceptions.TooManyRequests as e:
            translated_text = original_text     # valor por defecto
            #continue                           # escribirá sólo en ES
        #
        # para probar si este código llega hasta las 200.000 filas,
        # dejar habilitada esta declaración y dejar comentadas las anteriores
        #translated_text = original_text
        
        sql_statement = f'''INSERT INTO traduccion (id, id_orden, id_client, idioma, texto) VALUES ({index}, {order_id}, {client_id}, '{code_language}', '{translated_text}');\n'''
        script_file.write(sql_statement)


        sleep(0.3)

