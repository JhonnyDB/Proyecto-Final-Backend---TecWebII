-- 												ELIMINAR PROCEDIMIENTOS SP
Drop procedure if exists ppcliente;
Drop procedure if exists ppusuario;
Drop procedure if exists ppcategoria;
Drop procedure if exists ppproducto;
Drop procedure if exists ppdetalle;
Drop procedure if exists pppago;

-- 												PROCEDIMIENTO SP CLIENTES

Delimiter //
Create procedure ppcliente(
  In pIdCliente INT ,
  In pNombreCliente VARCHAR(20) ,
  In pApellidoCliente VARCHAR(20) ,
  In pDireccion VARCHAR(100) ,
  In pFechaNacimiento DATE ,
  In pCelular INT ,
  In pEmail VARCHAR(30) ,
  In pPais VARCHAR(30) ,
  In pCiudad VARCHAR(30) 
)
Begin
declare CodigoC int default 0;
if pIdCliente = 0 then
	set CodigoC = (select ifnull(max(IdCliente) ,0) +1 From cliente);
    INSERT INTO cliente (IdCliente, NombreCliente, ApellidoCliente, Direccion, FechaNacimiento, Celular, Email, Pais, Ciudad) 
	VALUES (CodigoC, pNombreCliente, pApellidoCliente, pDireccion, pFechaNacimiento, pCelular, pEmail, pPais, pCiudad);
else
	Update cliente Set NombreCliente = pNombreCliente, ApellidoCliente = pApellidoCliente, Direccion = pDireccion, FechaNacimiento = pFechaNacimiento
    , Celular = pCelular, Email = pEmail, Pais = pPais, Ciudad = pCiudad
    where IdCliente = pIdCliente;
end if;
end //
Delimiter //

-- 												PROCEDIMIENTO SP USUARIO

Delimiter //
Create procedure ppusuario(
  In pIdUsuario INT ,
  In pNombreDeUsuario VARCHAR(20) ,
  In pContraseña VARCHAR(70) ,
  In pIdCliente INT 
)
Begin
declare CodigoU int default 0;
if pIdUsuario = 0 then
	set CodigoU = (select ifnull(max(IdUsuario) ,0) +1 From usuario);
    INSERT INTO usuario (IdUsuario, NombreDeUsuario, Contraseña, IdCliente) 
	VALUES (CodigoU, pNombreDeUsuario, pContraseña, pIdCliente);
else
	Update usuario Set NombreDeUsuario = pNombreDeUsuario, Contraseña = pContraseña, IdCliente = pIdCliente
    where IdUsuario = pIdUsuario;
end if;
end //
Delimiter //

-- 												PROCEDIMIENTO SP CATEGORIA


Delimiter //
Create procedure ppcategoria(
  In pIdCategoria INT ,
  In pDescripcionCategoria VARCHAR(50) 
)
Begin
declare CodigoCa int default 0;
if pIdCategoria = 0 then
	set CodigoCa = (select ifnull(max(IdCategoria) ,0) +1 From categoria);
    INSERT INTO categoria (IdCategoria, DescripcionCategoria) 
	VALUES (CodigoCa, pDescripcionCategoria);
else
	Update categoria Set  DescripcionCategoria = pDescripcionCategoria
    where IdCategoria = pIdCategoria;
end if;
end //
Delimiter //


-- 												PROCEDIMIENTO SP PRODUCTO

Delimiter //
Create procedure ppproducto(
  In pIdProducto INT ,
  In PNombreProducto VARCHAR(30) ,
  In pMarca VARCHAR(30) ,
  In pPrecioU FLOAT ,
  In pStock INT ,
  In pIdCategoria INT,
  In pImagen VARCHAR(255)
)
Begin
declare CodigoPr int default 0;
if pIdProducto = 0 then
	set CodigoPr = (select ifnull(max(IdProducto) ,0) +1 From producto);
    INSERT INTO producto (IdProducto, NombreProducto, Marca, PrecioU, Stock, IdCategoria, Imagen) 
	VALUES (CodigoPr, PNombreProducto, pMarca, pPrecioU, pStock, pIdCategoria, pImagen);
else
	Update producto Set NombreProducto = PNombreProducto, Marca = pMarca, PrecioU = pPrecioU, Stock = pStock, IdCategoria = pIdCategoria, Imagen = pImagen
    where IdProducto = pIdProducto;
end if;
end //
Delimiter //

-- 												PROCEDIMIENTO SP DETALLE

Delimiter //
Create procedure ppdetalle(
  In pNumDetalle INT ,
  In pCantidad INT ,
  In pPrecioUnitario FLOAT ,
  In pIdProducto INT 
)
Begin
declare CodigoD int default 0;
if pNumDetalle = 0 then
	set CodigoD = (select ifnull(max(NumDetalle) ,0) +1 From detalle);
    INSERT INTO detalle (NumDetalle, Cantidad, PrecioUnitario, IdProducto) 
	VALUES (CodigoD, pCantidad, pPrecioUnitario, pIdProducto);
else
	Update detalle Set Cantidad = pCantidad, PrecioUnitario = pPrecioUnitario, IdProducto = pIdProducto
    where NumDetalle = pNumDetalle;
end if;
end //
Delimiter //

-- 												PROCEDIMIENTO SP PAGO

Delimiter //
Create procedure pppago(
  In pNumPago INT ,
  In pFecha DATE ,
  In pModoDePago ENUM('Transferencia', 'Pago QR', 'Tigo Money') ,
  In pIdUsuario INT ,
  In pNumDetalle INT 
)
Begin
declare CodigoPa int default 0;
if pNumPago = 0 then
	set CodigoPa = (select ifnull(max(NumPago) ,0) +1 From pago);
    INSERT INTO pago (NumPago, Fecha, ModoDePago, IdUsuario, NumDetalle) 
	VALUES (CodigoPa, pFecha, pModoDePago, pIdUsuario, pNumDetalle);
else
	Update pago Set Fecha = pFecha, ModoDePago = pModoDePago, IdUsuario = pIdUsuario, NumDetalle = pNumDetalle
    where NumPago = pNumPago;
end if;
end //
Delimiter //

call ppcliente ('0', 'Dery', 'Andres del Villar', 'Don Bosco', '2002-02-15', '21478932', 'deryandres@gmail.com', 'La Paz', 'El alto');
call ppusuario ( 0, 'DAndres111', '8765', 4);
call ppcategoria (0, 'Memorias USB');
call ppproducto (0, 'Memoria USB 8GB', 'HP', 45, 10, 9, null);
call ppdetalle (0, '20', '1800', '1');
call pppago (0, '2022-09-22', 1, 4, 4);

