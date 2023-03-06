//------------------------------------------------------------------
//                   Importa lo que hay en Database.js                
// -----------------------------------------------------------------

const conexion = require ('../BD/Database.js')
const express = require('express');
const cors = require('cors');
const encrypt = require ('bcryptjs');

const app = express();
app.use(express.json());
app.use(cors());

const route = express.Router()

//                                                              Reporte general        


route.get("/",(req,res)=>{
    conexion.query("Select cliente.IdCliente, NombreCliente, ApellidoCliente, Direccion, Celular, Email, usuario.IdUsuario, NombreDeUsuario, pago.NumPago, Fecha, ModoDePago, producto.NombreProducto, PrecioU, detalle.Cantidad, (detalle.Cantidad * producto.PrecioU) Monto from cliente, usuario, pago, producto, detalle where cliente.IdCliente = usuario.IdCliente and usuario.IdUsuario = pago.IdUsuario and pago.NumPago = detalle.NumPago and detalle.IdProducto = producto.IdProducto;", (error,filas) => {
    if (error){
        throw error
    }else{
        res.send(filas);
    }
});
}); 

//                                                              Reporte rango de fechas   

route.get("/:Fecha1/:Fecha2",(req,res)=>{
let Fecha1 = req.params.Fecha1
let Fecha2 = req.params.Fecha2
let sql = "Select cliente.IdCliente, NombreCliente, ApellidoCliente, Direccion, Celular, Email, usuario.IdUsuario, NombreDeUsuario, pago.NumPago, Fecha, ModoDePago, producto.NombreProducto, PrecioU, detalle.Cantidad, (detalle.Cantidad * producto.PrecioU) Monto from cliente, usuario, pago, producto, detalle where cliente.IdCliente = usuario.IdCliente and usuario.IdUsuario = pago.IdUsuario and pago.NumPago = detalle.NumPago and pago.Fecha between ? and ? and detalle.IdProducto = producto.IdProducto;"
conexion.query (sql, [Fecha1, Fecha2], function(error, result){
    if (error){
        throw error
    }else{
        res.send(result)
    } 
})
});

//                                                              Reporte especifico por cliente

route.get("/:IdCliente",(req,res)=>{
let IdCliente = req.params.IdCliente
let sql = "Select cliente.IdCliente, NombreCliente, ApellidoCliente, Direccion, Celular, Email, usuario.IdUsuario, NombreDeUsuario, pago.NumPago, Fecha, ModoDePago, producto.NombreProducto, PrecioU, detalle.Cantidad, (detalle.Cantidad * producto.PrecioU) Monto from cliente, usuario, pago, producto, detalle where cliente.IdCliente = usuario.IdCliente and usuario.IdUsuario = pago.IdUsuario and pago.NumDetalle = detalle.NumDetalle and cliente.IdCliente = ? and detalle.IdProducto = producto.IdProducto;"
conexion.query (sql, [IdCliente], function(error, result){
    if (error){
        throw error
    }else{
        res.send(result)
    } 
    })
});


module.exports = route;