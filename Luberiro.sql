
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
    Idioma VARCHAR(20),
    Texto TEXT,
    PRIMARY KEY (ID_Orden, Idioma),
    FOREIGN KEY (ID_Orden) REFERENCES Orden_de_trabajo(ID)
);

-- TABLA: Traduccion_orden
-- FORMATO: ID_Orden, Idioma, Texto

INSERT INTO Traduccion_orden VALUES
(1, 'es', 'Cambio de aceite y filtro de aceite.'),
(1, 'en', 'Oil and oil filter change.'),
(1, 'ar', 'تغيير الزيت وفلتر الزيت.'),
(1, 'zh', '更换机油和机油滤清器。'),
(1, 'fr', 'Changement d’huile et de filtre à huile.'),
(1, 'ru', 'Замена масла и масляного фильтра.');

INSERT INTO Traduccion_orden VALUES
(2, 'es', 'Revisión de frenos.'),
(2, 'en', 'Brake inspection.'),
(2, 'ar', 'فحص المكابح.'),
(2, 'zh', '刹车检查。'),
(2, 'fr', 'Inspection des freins.'),
(2, 'ru', 'Проверка тормозов.');

INSERT INTO Traduccion_orden VALUES
(3, 'es', 'Grabado de patentes.'),
(3, 'en', 'License plate engraving.'),
(3, 'ar', 'نقش لوحة الترخيص.'),
(3, 'zh', '车牌雕刻。'),
(3, 'fr', 'Gravure de la plaque d’immatriculation.'),
(3, 'ru', 'Гравировка номерных знаков.');

INSERT INTO Traduccion_orden VALUES
(4, 'es', 'Mantención programada.'),
(4, 'en', 'Scheduled maintenance.'),
(4, 'ar', 'صيانة مجدولة.'),
(4, 'zh', '计划维护。'),
(4, 'fr', 'Entretien programmé.'),
(4, 'ru', 'Плановое техническое обслуживание.');

INSERT INTO Traduccion_orden VALUES
(5, 'es', 'Alineación y balanceo.'),
(5, 'en', 'Alignment and balancing.'),
(5, 'ar', 'محاذاة وتوازن العجلات.'),
(5, 'zh', '车轮定位和平衡。'),
(5, 'fr', 'Alignement et équilibrage.'),
(5, 'ru', 'Развал-схождение и балансировка.');

INSERT INTO Traduccion_orden VALUES
(6, 'es', 'Cambio de batería.'),
(6, 'en', 'Battery replacement.'),
(6, 'ar', 'استبدال البطارية.'),
(6, 'zh', '更换电池。'),
(6, 'fr', 'Remplacement de la batterie.'),
(6, 'ru', 'Замена аккумулятора.');

INSERT INTO Traduccion_orden VALUES
(7, 'es', 'Diagnóstico de motor.'),
(7, 'en', 'Engine diagnostics.'),
(7, 'ar', 'تشخيص المحرك.'),
(7, 'zh', '发动机诊断。'),
(7, 'fr', 'Diagnostic moteur.'),
(7, 'ru', 'Диагностика двигателя.');

INSERT INTO Traduccion_orden VALUES
(8, 'es', 'Instalación de neumáticos nuevos.'),
(8, 'en', 'Installation of new tires.'),
(8, 'ar', 'تركيب إطارات جديدة.'),
(8, 'zh', '安装新轮胎。'),
(8, 'fr', 'Installation de nouveaux pneus.'),
(8, 'ru', 'Установка новых шин.');

INSERT INTO Traduccion_orden VALUES
(9, 'es', 'Revisión del sistema eléctrico.'),
(9, 'en', 'Electrical system check.'),
(9, 'ar', 'فحص النظام الكهربائي.'),
(9, 'zh', '检查电气系统。'),
(9, 'fr', 'Vérification du système électrique.'),
(9, 'ru', 'Проверка электрической системы.');

INSERT INTO Traduccion_orden VALUES
(10, 'es', 'Reemplazo de luces delanteras.'),
(10, 'en', 'Headlight replacement.'),
(10, 'ar', 'استبدال المصابيح الأمامية.'),
(10, 'zh', '更换前大灯。'),
(10, 'fr', 'Remplacement des phares avant.'),
(10, 'ru', 'Замена передних фар.');
