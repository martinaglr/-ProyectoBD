from faker import Faker
import random
from datetime import datetime, timedelta

fake = Faker('es_CL')

fecha_inicial = datetime(2010, 1, 1)

with open('script_carga_cotizacion.sql', 'w', encoding='utf-8') as f:
    for i in range(1, 20001):
        id_cajero = random.randint(1, 11)

        fecha = fecha_inicial + timedelta(days=i // 5)
        fecha_str = fecha.strftime('%Y-%m-%d')

        costo = random.randint(10000, 500000)

        f.write(f"INSERT INTO Cotizacion (id, id_cliente, id_cajero, id_auto, fecha, costo) "
                f"VALUES ({i}, {i}, {id_cajero}, {i}, '{fecha_str}', '${costo}');\n")
