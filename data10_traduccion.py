from faker import Faker
import random
from deep_translator import GoogleTranslator
import unicodedata

detalles = [
    "Cambio de aceite y filtro",
    "Reemplazo de frenos",
    "Alineación y balanceo",
    "Revisión de suspensión",
    "Cambio de batería",
    "Reparación de transmisión",
    "Inspección de sistema eléctrico",
    "Reemplazo de bujías",
    "Revisión de sistema de refrigeración",
    "Mantenimiento de sistema de escape",
    "Reemplazo de correa de distribución",
    "Revisión de sistema de dirección",
    "Cambio de líquido de frenos",
    "Reemplazo de filtro de aire",
    "Revisión de sistema de combustible",
    "Inspección de neumáticos",
    "Reemplazo de amortiguadores",
    "Revisión de luces y señales",
    "Reparación de sistema de escape",
    "Mantenimiento de sistema de climatización"
]

# Usamos códigos válidos de idioma según GoogleTranslator
idiomas = ['es', 'en', 'fr', 'ar', 'zh-CN', 'ru']

fake = Faker('es_CL')

with open('script_carga_traduccion.sql', 'w', encoding='utf-8') as f:
    for i in range(1, 20001):
        id_orden = random.randint(1, 20001)
        id_cliente = random.randint(1, 20001)
        idioma_codigo = random.choice(idiomas)
        texto_original = random.choice(detalles)

        # Normalizamos para evitar errores de codificación
        texto_original = unicodedata.normalize('NFKD', texto_original)

        if idioma_codigo == 'es':
            texto_traducido = texto_original
        else:
            try:
                texto_traducido = GoogleTranslator(source='es', target=idioma_codigo).translate(texto_original)
            except Exception as e:
                print(f"Error al traducir el texto '{texto_original}' a '{idioma_codigo}': {e}")
                texto_traducido = texto_original


        texto_traducido = texto_traducido.replace("'", "''")

        f.write(f"INSERT INTO Traduccion (id, id_orden, id_cliente, idioma, texto) "
                f"VALUES ({i}, {id_orden}, {id_cliente}, '{idioma_codigo}', '{texto_traducido}');\n")
