DROP DATABASE IF EXISTS `Luberiro`;
CREATE DATABASE `Luberiro`;
USE `Luberiro`;

CREATE TABLE Cliente (
    ID INT PRIMARY KEY,
    Rut VARCHAR(12),
    Nombre VARCHAR(100),
    Correo VARCHAR(100),
    Telefono VARCHAR(15)
);

CREATE TABLE Cajero (
    ID INT PRIMARY KEY,
    Rut VARCHAR(12),
    Nombre VARCHAR(100),
    Correo VARCHAR(100),
    Telefono VARCHAR(15)
);

CREATE TABLE Mecanico (
    ID INT PRIMARY KEY,
    Rut VARCHAR(12),
    Nombre VARCHAR(100),
    Correo VARCHAR(100),
    Telefono VARCHAR(15),
    Area VARCHAR(50)
);

CREATE TABLE Repuesto (
    ID INT PRIMARY KEY,
    Nombre VARCHAR(80),
    Precio DECIMAL(10,2),
    Marca VARCHAR(80),
    Modelo VARCHAR(80),
    Serial VARCHAR(50)
);

CREATE TABLE Auto (
    ID INT PRIMARY KEY,
    ID_Cliente INT,
    Marca VARCHAR(50),
    Modelo VARCHAR(50),
    Motor VARCHAR(20),
    Kilometraje INT,
    Fecha TIMESTAMP,
    Seguro VARCHAR(40),
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID)
);

CREATE TABLE Cotizacion (
    ID INT PRIMARY KEY,
    ID_Cliente INT,
    ID_Cajero INT,
    ID_Auto INT,
    Fecha TIMESTAMP,
    Costo DECIMAL(10,2),
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID),
    FOREIGN KEY (ID_Cajero) REFERENCES Cajero(ID),
    FOREIGN KEY (ID_Auto) REFERENCES Auto(ID)
);

CREATE TABLE Reparacion (
    ID INT PRIMARY KEY,
    ID_Mecanico INT,
    ID_Cotizacion INT,
    ID_Repuesto INT,
    Tipo VARCHAR(100),
    Fecha_Inicio TIMESTAMP,
    Fecha_Termino TIMESTAMP,
    Detalle VARCHAR(100),
    Costo DECIMAL(10,2),
    FOREIGN KEY (ID_Mecanico) REFERENCES Mecanico(ID),
    FOREIGN KEY (ID_Cotizacion) REFERENCES Cotizacion(ID),
    FOREIGN KEY (ID_Repuesto) REFERENCES Repuesto(ID)
);

CREATE TABLE Orden_de_trabajo (
    ID INT PRIMARY KEY,
    ID_Cotizacion INT,
    Fecha_Recepcion TIMESTAMP,
    Estado CHAR(1),
    FOREIGN KEY (ID_Cotizacion) REFERENCES Cotizacion(ID)
);

CREATE TABLE Pago (
    ID INT PRIMARY KEY,
    ID_Cliente INT,
    ID_Orden INT,
    ID_Cajero INT,
    Costo DECIMAL(10,2),
    Moneda VARCHAR(3),
    Estado CHAR(1),
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID),
    FOREIGN KEY (ID_Orden) REFERENCES Orden_de_trabajo(ID),
    FOREIGN KEY (ID_Cajero) REFERENCES Cajero(ID)
);

CREATE TABLE Traduccion_orden (
    ID_Orden INT,
    ID_Cliente INT,
    Idioma VARCHAR(20),
    Texto TEXT,
    PRIMARY KEY (ID_Orden, ID_Cliente, Idioma),
    FOREIGN KEY (ID_Orden) REFERENCES Orden_de_trabajo(ID),
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID)
);
