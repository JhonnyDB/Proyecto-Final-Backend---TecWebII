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
  DescripcionCategoria VARCHAR(100) ,
  PRIMARY KEY (IdCategoria))
;

-- -----------------------------------------------------
-- -----------------------------------------------------
CREATE TABLE cliente (
  IdCliente INT ,
  NombreCliente VARCHAR(15) ,
  ApellidoCliente VARCHAR(20) ,
  Direccion VARCHAR(50) ,
  FechaNacimiento DATE ,
  Celular INT ,
  Email VARCHAR(30) ,
  Pais VARCHAR(20) ,
  Ciudad VARCHAR(30) ,
  PRIMARY KEY (IdCliente))
;

-- -----------------------------------------------------
-- -----------------------------------------------------
CREATE TABLE producto (
  IdProducto INT ,
  NombreProducto VARCHAR(25) ,
  Marca VARCHAR(20) ,
  PrecioU FLOAT ,
  Stock INT ,
  IdCategoria INT ,
  PRIMARY KEY (IdProducto),

    FOREIGN KEY (IdCategoria)
    REFERENCES categoria (IdCategoria))
;

-- -----------------------------------------------------
-- -----------------------------------------------------
CREATE TABLE usuario (
  IdUsuario INT auto_increment,
  NombreDeUsuario VARCHAR(20) ,
  Contraseña VARCHAR(70) NOT NULL default('') ,
  IdCliente INT ,
  PRIMARY KEY (IdUsuario),

    FOREIGN KEY (IdCliente)
    REFERENCES cliente (IdCliente))
;

-- -----------------------------------------------------
-- -----------------------------------------------------
CREATE TABLE pago (
  NumPago INT ,
  Fecha DATE ,
  ModoDePago ENUM('Transferencia', 'Pago QR', 'Tigo Money') ,
  IdUsuario INT ,
  IdProducto INT ,
  PRIMARY KEY (NumPago),

    FOREIGN KEY (IdUsuario)
    REFERENCES usuario (IdUsuario),

    FOREIGN KEY (IdProducto)
    REFERENCES producto (IdProducto))
;

-- -----------------------------------------------------
-- -----------------------------------------------------
CREATE TABLE detalle (
  NumDetalle INT ,
  Cantidad INT ,
  PrecioTotal FLOAT ,
  NumPago INT ,
  PRIMARY KEY (NumDetalle),

    FOREIGN KEY (NumPago)
    REFERENCES pago (NumPago)
);

INSERT INTO `cliente` (`IdCliente`, `NombreCliente`, `ApellidoCliente`, `Direccion`, `FechaNacimiento`, `Celular`, `Email`, `Pais`, `Ciudad`) 
VALUES ('1', 'Jhonny', 'Mamani Valda', 'Villa Salome', '2002-02-28', '12497321', 'jhonny@gmail.com', 'La Paz', 'El alto');
INSERT INTO `cliente` (`IdCliente`, `NombreCliente`, `ApellidoCliente`, `Direccion`, `FechaNacimiento`, `Celular`, `Email`, `Pais`, `Ciudad`) 
VALUES ('2', 'Jaqueline', 'Mamani Sirpa', 'Alto Pampahasi', '2002-10-11', '24187612', 'jaqueline@gmail.com', 'La Paz', 'Nuestra señora de La Paz');
INSERT INTO `cliente` (`IdCliente`, `NombreCliente`, `ApellidoCliente`, `Direccion`, `FechaNacimiento`, `Celular`, `Email`, `Pais`, `Ciudad`) 
VALUES ('3', 'Jhonatan', 'Guachalla Tintaya', 'Alto Pampahasi', '2002-03-28', '99473213', 'jhonatan@gmail.com', 'La Paz', 'El alto');

select * from cliente;

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

INSERT INTO `producto` (`IdProducto`, `NombreProducto`, `Marca`, `PrecioU`, `Stock`, `IdCategoria`) VALUES (1, 'LG 24 pulgadas', 'LG', 1800, 10, 1);
INSERT INTO `producto` (`IdProducto`, `NombreProducto`, `Marca`, `PrecioU`, `Stock`, `IdCategoria`) VALUES (2, 'Mouse gamer', 'Altisimo', 250, 10, 2);
INSERT INTO `producto` (`IdProducto`, `NombreProducto`, `Marca`, `PrecioU`, `Stock`, `IdCategoria`) VALUES (3, 'Mouse escritorio', 'Altisimo', 50, 10, 3);
INSERT INTO `producto` (`IdProducto`, `NombreProducto`, `Marca`, `PrecioU`, `Stock`, `IdCategoria`) VALUES (4, 'Teclado', 'Red Dragon', 1400, 10, 4);
INSERT INTO `producto` (`IdProducto`, `NombreProducto`, `Marca`, `PrecioU`, `Stock`, `IdCategoria`) VALUES (5, 'Tarjeta', 'ASUS', 1000, 10, 5);
INSERT INTO `producto` (`IdProducto`, `NombreProducto`, `Marca`, `PrecioU`, `Stock`, `IdCategoria`) VALUES (6, 'MousePad', 'UwU', 100, 10, 6);
INSERT INTO `producto` (`IdProducto`, `NombreProducto`, `Marca`, `PrecioU`, `Stock`, `IdCategoria`) VALUES (7, 'Memoria', 'Coursair', 500, 10, 7);
INSERT INTO `producto` (`IdProducto`, `NombreProducto`, `Marca`, `PrecioU`, `Stock`, `IdCategoria`) VALUES (8, 'Laptop', 'MSI', 7000, 10, 8);

INSERT INTO `pago` (`NumPago`, `Fecha`, `ModoDePago`, `IdUsuario`, `IdProducto`) VALUES (1, '2023-01-10', '1', 1, 1);
INSERT INTO `pago` (`NumPago`, `Fecha`, `ModoDePago`, `IdUsuario`, `IdProducto`) VALUES (2, '2023-02-10', '2', 2, 2);
INSERT INTO `pago` (`NumPago`, `Fecha`, `ModoDePago`, `IdUsuario`, `IdProducto`) VALUES (3, '2023-03-10', '3', 3, 3);

INSERT INTO `detalle` (`NumDetalle`, `Cantidad`, `PrecioTotal`, `NumPago`) VALUES (1, '2', '1800', '1');
INSERT INTO `detalle` (`NumDetalle`, `Cantidad`, `PrecioTotal`, `NumPago`) VALUES (2, '5', '250', '2');
INSERT INTO `detalle` (`NumDetalle`, `Cantidad`, `PrecioTotal`, `NumPago`) VALUES (3, '4', '50', '3');

-- REPORTE GENERAL

select * from pago;

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
and pago.Fecha between '2023-01-10' and '2023-03-10'
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

-- FACTURA

use SistemaVenta;
Select  cliente.IdCliente, usuario.IdUsuario, pago.Fecha, producto.NombreProducto, Marca, detalle.Cantidad, (detalle.Cantidad * producto.PrecioU) Monto
from cliente, usuario, pago, producto, detalle
where cliente.IdCliente = usuario.IdCliente 
and usuario.IdUsuario = pago.IdUsuario
and pago.IdProducto = producto.IdProducto
and pago.NumPago = detalle.NumPago;

select * from pago;

use SistemaVenta;
SELECT producto.NombreProducto, detalle.Cantidad
FROM producto, detalle
WHERE detalle.IdProducto = producto.IdProducto
ORDER BY detalle.Cantidad DESC;
