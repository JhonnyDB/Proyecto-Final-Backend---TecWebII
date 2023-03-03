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
  NombreCliente VARCHAR(45) ,
  ApellidoCliente VARCHAR(45) ,
  Direccion VARCHAR(100) ,
  FechaNacimiento DATE ,
  Celular INT ,
  Email VARCHAR(100) ,
  Pais VARCHAR(45) ,
  Ciudad VARCHAR(45) ,
  PRIMARY KEY (IdCliente))
;

-- -----------------------------------------------------
-- -----------------------------------------------------
CREATE TABLE producto (
  IdProducto INT ,
  NombreProducto VARCHAR(45) ,
  Marca VARCHAR(45) ,
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
  IdUsuario INT NOT NULL,
  NombreDeUsuario VARCHAR(45) NULL DEFAULT NULL,
  Contraseña VARCHAR(45) NULL DEFAULT NULL,
  IdCliente INT NULL DEFAULT NULL,
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
  IdProducto INT ,
  NumPago INT ,
  PRIMARY KEY (NumDetalle),

    FOREIGN KEY (IdProducto)
    REFERENCES producto (IdProducto),

    FOREIGN KEY (NumPago)
    REFERENCES pago (NumPago)
);

INSERT INTO `cliente` (`IdCliente`, `NombreCliente`, `ApellidoCliente`, `Direccion`, `FechaNacimiento`, `Celular`, `Email`, `Pais`, `Ciudad`) 
VALUES ('1', 'Jhonny', 'Mamani Valda', 'Villa Salome', '2002-02-28', '12497321', 'jhonny@gmail.com', 'La Paz', 'El alto');
INSERT INTO `cliente` (`IdCliente`, `NombreCliente`, `ApellidoCliente`, `Direccion`, `FechaNacimiento`, `Celular`, `Email`, `Pais`, `Ciudad`) 
VALUES ('2', 'Jaqueline', 'Mamani Sirpa', 'Alto Pampahasi', '2002-10-11', '24187612', 'jaqueline@gmail.com', 'La Paz', 'Nuestra señora de La Paz');
INSERT INTO `cliente` (`IdCliente`, `NombreCliente`, `ApellidoCliente`, `Direccion`, `FechaNacimiento`, `Celular`, `Email`, `Pais`, `Ciudad`) 
VALUES ('3', 'Jhonatan', 'Guachalla Tintaya', 'Alto Pampahasi', '2002-03-28', '99473213', 'jhonatan@gmail.com', 'La Paz', 'El alto');
INSERT INTO `cliente` (`IdCliente`, `NombreCliente`, `ApellidoCliente`, `Direccion`, `FechaNacimiento`, `Celular`, `Email`, `Pais`, `Ciudad`) 
VALUES ('10', 'Jhonatan', 'Guachalla Tintaya', 'Alto Pampahasi', '2002-03-28', '99473213', 'jhonatan@gmail.com', 'La Paz', 'El alto');

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

INSERT INTO `pago` (`NumPago`, `Fecha`, `ModoDePago`, `IdUsuario`, `IdProducto`) VALUES (1, '2022-08-31', '1', 1, 1);
INSERT INTO `pago` (`NumPago`, `Fecha`, `ModoDePago`, `IdUsuario`, `IdProducto`) VALUES (2, '2022-08-31', '2', 2, 2);
INSERT INTO `pago` (`NumPago`, `Fecha`, `ModoDePago`, `IdUsuario`, `IdProducto`) VALUES (3, '2022-08-31', '3', 3, 3);

INSERT INTO `detalle` (`NumDetalle`, `Cantidad`, `PrecioTotal`, `IdProducto`, `NumPago`) VALUES (1, '2', '1800', '1', '1');
INSERT INTO `detalle` (`NumDetalle`, `Cantidad`, `PrecioTotal`, `IdProducto`, `NumPago`) VALUES (2, '5', '250', '2', '2');
INSERT INTO `detalle` (`NumDetalle`, `Cantidad`, `PrecioTotal`, `IdProducto`, `NumPago`) VALUES (3, '4', '50', '3', '3');

-- REPORTE GENERAL

select * from pago;

use SistemaVenta;
Select cliente.IdCliente, NombreCliente, ApellidoCliente, Direccion, Celular, Email, usuario.IdUsuario, NombreDeUsuario, pago.NumPago, 
Fecha, ModoDePago, producto.NombreProducto, PrecioU, detalle.Cantidad, (detalle.Cantidad * producto.PrecioU) Monto
from cliente, usuario, pago, producto, detalle
where cliente.IdCliente = usuario.IdCliente 
and usuario.IdUsuario = pago.IdUsuario
and pago.IdProducto = producto.IdProducto
and pago.NumPago = detalle.NumPago;

-- REPORTE POR FECHAS

use SistemaVenta;
Select cliente.IdCliente, NombreCliente, ApellidoCliente, Direccion, Celular, Email, usuario.IdUsuario, NombreDeUsuario, pago.NumPago, 
Fecha, ModoDePago, producto.NombreProducto, PrecioU, detalle.Cantidad, (detalle.Cantidad * producto.PrecioU) Monto
from cliente, usuario, pago, producto, detalle
where cliente.IdCliente = usuario.IdCliente 
and usuario.IdUsuario = pago.IdUsuario
and pago.IdProducto = producto.IdProducto
and pago.Fecha between '2022-08-01' and '2022-08-31'
and pago.NumPago = detalle.NumPago;

-- REPORTE Especifico de cliente

use SistemaVenta;
Select cliente.IdCliente, NombreCliente, ApellidoCliente, Direccion, Celular, Email, usuario.IdUsuario, NombreDeUsuario, pago.NumPago, 
Fecha, ModoDePago, producto.NombreProducto, PrecioU, detalle.Cantidad, (detalle.Cantidad * producto.PrecioU) Monto
from cliente, usuario, pago, producto, detalle
where cliente.IdCliente = usuario.IdCliente 
and usuario.IdUsuario = pago.IdUsuario
and pago.IdProducto = producto.IdProducto
and cliente.IdCliente = 1
and pago.NumPago = detalle.NumPago;

-- FACTURA

use SistemaVenta;
Select  cliente.IdCliente, usuario.IdUsuario, pago.Fecha, producto.NombreProducto, Marca, detalle.Cantidad, (detalle.Cantidad * producto.PrecioU) Monto
from cliente, usuario, pago, producto, detalle
where cliente.IdCliente = usuario.IdCliente 
and usuario.IdUsuario = pago.IdUsuario
and pago.IdProducto = producto.IdProducto
and pago.NumPago = detalle.NumPago;


select * from categoria
