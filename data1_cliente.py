from faker import Faker
import random

fake = Faker('es_CL')

def generar_rut():  
    cuerpo = str(random.randint(1000000, 25000000))
    dv = random.choice('0123456789K')
    return f"{cuerpo}-{dv}"

with open('script_carga_cliente.sql', 'w', encoding='utf-8') as f:
    for i in range(1, 20001):
        rut = generar_rut()
        nombre = fake.name()
        email = fake.email()
        telefono = fake.phone_number()
        
        f.write(f"INSERT INTO Cliente (id, rut, nombre, correo, telefono) "
                f"VALUES ('{i}', '{rut}', '{nombre}', '{email}', '{telefono}');\n")
        