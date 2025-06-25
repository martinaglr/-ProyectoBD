from faker import Faker
import random
import string

fake = Faker('es_CL')

nombres = [
    "Frenos",
    "Filtros de aire",
    "Filtros de aceite",
    "Bujías",
    "Amortiguadores",
    "Baterías",
    "Correas de distribución",
    "Pastillas de freno",
    "Aceite de motor",
    "Líquido de frenos",
    "Líquido refrigerante",
    "Bombas de agua",
    "Sensores de oxígeno",
    "Bobinas de encendido",
    "Cables de bujías",
    "Lámparas de faros",
    "Limpiaparabrisas",
    "Escobillas limpiaparabrisas",
    "Filtros de combustible",
    "Aceite de transmisión"
]

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

def generar_precios(): 
    return random.randint(10000, 250000)

def generar_serial_sku(longitud=10):
    return ''.join(random.choices(string.ascii_uppercase + string.digits, k=longitud))

with open('script_carga_repuesto.sql', 'w', encoding='utf-8') as f:
    for i in range(1, 20001):
        nombre = random.choice(nombres)
        precio = generar_precios()
        marca = random.choice(marcas)
        serial = generar_serial_sku()
        
        f.write(f"INSERT INTO Repuesto (id, nombre, precio, marca, serial) "
                f"VALUES ('{i}', '{nombre}', '{precio}', '{marca}', '{serial}');\n")