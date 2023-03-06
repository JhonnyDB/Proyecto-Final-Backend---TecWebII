-- -----------------------------------------------------
-- 					ELIMINAR BASE DE DATOS
-- -----------------------------------------------------

Drop database SistemaVenta;
-- -----------------------------------------------------
-- 					CREAR BASE DE DATOS
-- -----------------------------------------------------

create database SistemaVenta;

-- -----------------------------------------------------
-- 				 	USAR BASE DE DATOS
-- -----------------------------------------------------

use SistemaVenta;

-- -----------------------------------------------------
-- -----------------------------------------------------
CREATE TABLE categoria (
  IdCategoria INT ,
  DescripcionCategoria VARCHAR(50) ,
  PRIMARY KEY (IdCategoria))
;

-- -----------------------------------------------------
-- -----------------------------------------------------
CREATE TABLE cliente (
  IdCliente INT ,
  NombreCliente VARCHAR(20) ,
  ApellidoCliente VARCHAR(20) ,
  Direccion VARCHAR(100) ,
  FechaNacimiento DATE ,
  Celular INT ,
  Email VARCHAR(30) ,
  Pais VARCHAR(30) ,
  Ciudad VARCHAR(30) ,
  PRIMARY KEY (IdCliente))
;

-- -----------------------------------------------------
-- -----------------------------------------------------
CREATE TABLE producto (
  IdProducto INT ,
  NombreProducto VARCHAR(30) ,
  Marca VARCHAR(30) ,
  PrecioU FLOAT ,
  Stock INT ,
  IdCategoria INT ,
  Imagen VARCHAR(255) ,
  PRIMARY KEY (IdProducto),

    FOREIGN KEY (IdCategoria)
    REFERENCES categoria (IdCategoria))
;

-- -----------------------------------------------------
-- -----------------------------------------------------
CREATE TABLE usuario (
  IdUsuario INT auto_increment,
  NombreDeUsuario VARCHAR(20) ,
  Contraseña VARCHAR(70) ,
  IdCliente INT ,
  PRIMARY KEY (IdUsuario),

    FOREIGN KEY (IdCliente)
    REFERENCES cliente (IdCliente))
;
-- -----------------------------------------------------
-- -----------------------------------------------------
CREATE TABLE detalle (
  NumDetalle INT ,
  Cantidad INT ,
  PrecioUnitario FLOAT ,
  IdProducto INT ,
  PRIMARY KEY (NumDetalle),

    FOREIGN KEY (IdProducto)
    REFERENCES producto (IdProducto)
);
-- -----------------------------------------------------
-- -----------------------------------------------------
CREATE TABLE pago (
  NumPago INT ,
  Fecha DATE ,
  ModoDePago ENUM('Transferencia', 'Pago QR', 'Tigo Money') ,
  IdUsuario INT ,
  NumDetalle INT ,
  PRIMARY KEY (NumPago),

    FOREIGN KEY (NumDetalle)
    REFERENCES detalle (NumDetalle),

    FOREIGN KEY (IdUsuario)
    REFERENCES usuario (IdUsuario))
;


INSERT INTO `cliente` (`IdCliente`, `NombreCliente`, `ApellidoCliente`, `Direccion`, `FechaNacimiento`, `Celular`, `Email`, `Pais`, `Ciudad`) 
VALUES ('1', 'Jhonny', 'Mamani Valda', 'Villa Salome', '2002-02-28', '12497321', 'jhonny@gmail.com', 'La Paz', 'El alto');
INSERT INTO `cliente` (`IdCliente`, `NombreCliente`, `ApellidoCliente`, `Direccion`, `FechaNacimiento`, `Celular`, `Email`, `Pais`, `Ciudad`) 
VALUES ('2', 'Jaqueline', 'Mamani Sirpa', 'Alto Pampahasi', '2002-10-11', '24187612', 'jaqueline@gmail.com', 'La Paz', 'Nuestra señora de La Paz');
INSERT INTO `cliente` (`IdCliente`, `NombreCliente`, `ApellidoCliente`, `Direccion`, `FechaNacimiento`, `Celular`, `Email`, `Pais`, `Ciudad`) 
VALUES ('3', 'Jhonatan', 'Guachalla Tintaya', 'Alto Pampahasi', '2002-03-28', '99473213', 'jhonatan@gmail.com', 'La Paz', 'El alto');

INSERT INTO `usuario` (`IdUsuario`, `NombreDeUsuario`, `Contraseña`, `IdCliente`) VALUES (1, 'Mushu', '1234', 1);
INSERT INTO `usuario` (`IdUsuario`, `NombreDeUsuario`, `Contraseña`, `IdCliente`) VALUES (2, 'Jaqui', '5678', 2);
INSERT INTO `usuario` (`IdUsuario`, `NombreDeUsuario`, `Contraseña`, `IdCliente`) VALUES (3, 'Jhon', '4321', 3);

INSERT INTO `categoria` (`IdCategoria`, `DescripcionCategoria`) VALUES (1, 'Monitores Gamer');
INSERT INTO `categoria` (`IdCategoria`, `DescripcionCategoria`) VALUES (2, 'Mouses Gamer');
INSERT INTO `categoria` (`IdCategoria`, `DescripcionCategoria`) VALUES (3, 'Mouses De Escritorio');
INSERT INTO `categoria` (`IdCategoria`, `DescripcionCategoria`) VALUES (4, 'Teclado Gamer');
INSERT INTO `categoria` (`IdCategoria`, `DescripcionCategoria`) VALUES (5, 'Tarjetas de video');
INSERT INTO `categoria` (`IdCategoria`, `DescripcionCategoria`) VALUES (6, 'Mousepads');
INSERT INTO `categoria` (`IdCategoria`, `DescripcionCategoria`) VALUES (7, 'Memorias RAM');
INSERT INTO `categoria` (`IdCategoria`, `DescripcionCategoria`) VALUES (8, 'Laptops Gamers');

INSERT INTO `producto` (`IdProducto`, `NombreProducto`, `Marca`, `PrecioU`, `Stock`, `IdCategoria`, `Imagen`) 
VALUES (1, 'LG 24 pulgadas', 'LG', 1800, 50, 1, null);
INSERT INTO `producto` (`IdProducto`, `NombreProducto`, `Marca`, `PrecioU`, `Stock`, `IdCategoria`, `Imagen`) 
VALUES (2, 'Mouse gamer', 'Altisimo', 250, 50, 2, null);
INSERT INTO `producto` (`IdProducto`, `NombreProducto`, `Marca`, `PrecioU`, `Stock`, `IdCategoria`, `Imagen`) 
VALUES (3, 'Mouse escritorio', 'Altisimo', 50, 10, 3, null);
INSERT INTO `producto` (`IdProducto`, `NombreProducto`, `Marca`, `PrecioU`, `Stock`, `IdCategoria`, `Imagen`)
VALUES (4, 'Teclado', 'Red Dragon', 1400, 50, 4, null);
INSERT INTO `producto` (`IdProducto`, `NombreProducto`, `Marca`, `PrecioU`, `Stock`, `IdCategoria`, `Imagen`) 
VALUES (5, 'Tarjeta', 'ASUS', 1000, 50, 5, null);
INSERT INTO `producto` (`IdProducto`, `NombreProducto`, `Marca`, `PrecioU`, `Stock`, `IdCategoria`, `Imagen`) 
VALUES (6, 'MousePad', 'UwU', 100, 50, 6, null);
INSERT INTO `producto` (`IdProducto`, `NombreProducto`, `Marca`, `PrecioU`, `Stock`, `IdCategoria`, `Imagen`) 
VALUES (7, 'Memoria', 'Coursair', 500, 50, 7, null);
INSERT INTO `producto` (`IdProducto`, `NombreProducto`, `Marca`, `PrecioU`, `Stock`, `IdCategoria`, `Imagen`) 
VALUES (8, 'Laptop', 'MSI', 7000, 50, 8, null);

INSERT INTO `detalle` (`NumDetalle`, `Cantidad`, `PrecioUnitario`, `IdProducto`) VALUES (1, '5', '1800', '1');
INSERT INTO `detalle` (`NumDetalle`, `Cantidad`, `PrecioUnitario`, `IdProducto`) VALUES (2, '10', '250', '2');
INSERT INTO `detalle` (`NumDetalle`, `Cantidad`, `PrecioUnitario`, `IdProducto`) VALUES (3, '15', '50', '3');

INSERT INTO `pago` (`NumPago`, `Fecha`, `ModoDePago`, `IdUsuario`, `NumDetalle`) VALUES (1, '2023-01-15', '1', 1, 1);
INSERT INTO `pago` (`NumPago`, `Fecha`, `ModoDePago`, `IdUsuario`, `NumDetalle`) VALUES (2, '2023-02-15', '2', 2, 2);
INSERT INTO `pago` (`NumPago`, `Fecha`, `ModoDePago`, `IdUsuario`, `NumDetalle`) VALUES (3, '2023-03-15', '3', 3, 3);

-- REPORTE GENERAL

select * from producto;

use SistemaVenta;
Select cliente.IdCliente, NombreCliente, ApellidoCliente, Direccion, Celular, Email, usuario.IdUsuario, NombreDeUsuario, pago.NumPago, 
Fecha, ModoDePago, producto.NombreProducto, PrecioU, detalle.Cantidad, (detalle.Cantidad * producto.PrecioU) Monto
from cliente, usuario, pago, producto, detalle
where cliente.IdCliente = usuario.IdCliente 
and usuario.IdUsuario = pago.IdUsuario
and pago.NumDetalle = detalle.NumDetalle
and detalle.IdProducto = producto.IdProducto;

-- REPORTE POR FECHAS

use SistemaVenta;
Select cliente.IdCliente, NombreCliente, ApellidoCliente, Direccion, Celular, Email, usuario.IdUsuario, NombreDeUsuario, pago.NumPago, 
Fecha, ModoDePago, producto.NombreProducto, PrecioU, detalle.Cantidad, (detalle.Cantidad * producto.PrecioU) Monto
from cliente, usuario, pago, producto, detalle
where cliente.IdCliente = usuario.IdCliente 
and usuario.IdUsuario = pago.IdUsuario
and pago.NumDetalle = detalle.NumDetalle
and pago.Fecha between '2023-01-01' and '2023-03-20'
and detalle.IdProducto = producto.IdProducto;

-- REPORTE Especifico de cliente

use SistemaVenta;
Select cliente.IdCliente, NombreCliente, ApellidoCliente, Direccion, Celular, Email, usuario.IdUsuario, NombreDeUsuario, pago.NumPago, 
Fecha, ModoDePago, producto.NombreProducto, PrecioU, detalle.Cantidad, (detalle.Cantidad * producto.PrecioU) Monto
from cliente, usuario, pago, producto, detalle
where cliente.IdCliente = usuario.IdCliente 
and usuario.IdUsuario = pago.IdUsuario
and pago.NumDetalle = detalle.NumDetalle
and cliente.IdCliente = 1
and detalle.IdProducto = producto.IdProducto;

select * from usuario;

use SistemaVenta;
SELECT producto.NombreProducto, detalle.Cantidad
FROM producto, detalle
WHERE detalle.IdProducto = producto.IdProducto
ORDER BY detalle.Cantidad DESC;
