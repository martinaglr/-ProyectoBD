from faker import Faker
import random
from datetime import datetime, timedelta

fake = Faker('es_CL')

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

fecha_inicial = datetime(2010, 1, 1)

with open('script_carga_reparacion.sql', 'w', encoding='utf-8') as f:
    for i in range(1, 20001):
        id_mecanico = random.randint(1, 11)
        id_repuesto = random.randint(1, 20001)
        Tipo = random.choice(['Reparación', 'Mantenimiento', 'Inspección', 'Diagnóstico'])

        fecha_inicio = fecha_inicial + timedelta(days=i // 5)
        fecha_termino = fecha_inicio + timedelta(days=random.randint(1, 10))
        fecha_inicio_str = fecha_inicio.strftime('%Y-%m-%d')
        fecha_termino_str = fecha_termino.strftime('%Y-%m-%d')
        detalle = random.choice(detalles)

        costo = random.randint(10000, 500000)

        f.write(f"INSERT INTO Reparacion (id, id_cliente, id_cajero, id_auto, fecha, costo) "
                f"VALUES ({i}, {id_mecanico}, {i}, {id_repuesto}, '{Tipo}', '{fecha_inicio}', '{fecha_termino}', '{detalle}', '{costo}');\n")