from faker import Faker
import random

fake = Faker('es_CL')

with open('script_carga_pago.sql', 'w', encoding='utf-8') as f:
    for i in range(1, 20001):
        id_cliente = random.randint(1, 20001)
        id_orden = random.randint(1, 20001)
        id_cajero = random.randint(1, 11)
        moneda = random.choice(['CLP', 'USD', 'EUR'])
        estado = random.choice(['Pendiente', 'Completada', 'Rechazada'])


        costo = random.randint(10000, 500000)

        f.write(f"INSERT INTO Pago (id, id_cliente, id_orden, id_cajero, costo, moneda, estado) "
                f"VALUES ({i}, {id_cliente}, {id_orden}, '{id_cajero}', '${costo}', '{moneda}', '{estado}');\n")

