from faker import Faker
import random
from datetime import datetime, timedelta

fake = Faker('es_CL')

fecha_inicial = datetime(2010, 1, 1)

with open('script_carga_odt.sql', 'w', encoding='utf-8') as f:
    for i in range(1, 100001):
        id_cotizacion = random.randint(1, 100001)

        fecha_recepcion = fecha_inicial + timedelta(days=i // 5)
        fecha_recepcion_str = fecha_recepcion.strftime('%Y-%m-%d')
        estado = random.choice(['Pendiente', 'Completada', 'Rechazada']) 

        f.write(f"INSERT INTO Orden_de_trabajo (id, id_cotizacion, fecha_recepcion, estado) "
                f"VALUES ({i}, {id_cotizacion}, {fecha_recepcion}, {estado});\n")
        
