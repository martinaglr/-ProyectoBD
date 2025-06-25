from faker import Faker
import random
from datetime import datetime, timedelta


fake = Faker('es_CL')

marcas = [
    "Toyota",
    "Ford",
    "Chevrolet",
    "Nissan",
    "Hyundai",
    "Kia",
    "Volkswagen",
    "Honda",
    "Subaru",
    "Mazda"
]

modelos = [
    "Corolla",
    "Focus",
    "Cruze",
    "Sentra",
    "Elantra",
    "Rio",
    "Golf",
    "Civic",
    "Impreza",
    "Mazda3"
]

motores = [
    "1.8L",
    "2.0L",
    "2.4L",
    "3.0L",
    "1.5L Turbo",
    "2.5L Turbo",
    "1.6L Diesel",
    "2.0L Diesel",
    "3.5L V6",
    "4.0L V6"
]

fecha_inicial = datetime(2010,1,1)

with open('script_carga_auto.sql', 'w', encoding='utf-8') as f:
    for i in range(1, 20001):
        marca = random.choice(marcas)
        modelo = random.choice(modelos)
        motor = random.choice(motores)
        kilometraje = random.randint(0, 300000)

        fecha = fecha_inicial + timedelta(days=i // 5)
        fecha_str = fecha.strftime('%Y-%m-%d')

        seguro = 'Si' if fake.boolean(chance_of_getting_true=70) else 'No'
        
        f.write(f"INSERT INTO Auto (id, id_cliente, marca, modelo, motor, kilometraje, fecha, seguro) "
                f"VALUES ('{i}', '{i}', '{marca}', '{modelo}', '{motor}', '{kilometraje}', '{fecha_str}', '{seguro}');\n")