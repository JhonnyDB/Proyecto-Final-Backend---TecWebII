//------------------------------------------------------------------
//                   Importa lo que hay en Database.js                
// -----------------------------------------------------------------

const conexion = require ('../BD/Database.js')
const express = require('express');
const cors = require('cors');

const app = express();
app.use(express.json());
app.use(cors());

const route = express.Router()

//------------------------------------------------------------------
//                                GET                 
// -----------------------------------------------------------------

route.get("/",(req,res)=>{
        conexion.query("Select * from pago", (error,filas) => {
        if (error){
            throw error
        }else{
            res.send(filas);
        }
    });
}); 

//------------------------------------------------------------------
//                                POST                 
// -----------------------------------------------------------------

route.post("/",(req,res)=>{
    let NumPago = 0; 
    let Fecha = req.body.Fecha;
    let ModoDePago = req.body.ModoDePago;
    let IdUsuario = req.body.IdUsuario;
    let IdProducto = req.body.IdProducto;
    let sql = "call pppago (?, ?, ?, ?, ?)"
    conexion.query (sql,[NumPago, Fecha, ModoDePago, IdUsuario , IdProducto], function(err, result){
        if (err){
            res.json(err.message)
        }else{
            res.json("Adicion realizada de manera exitosa")
        }
    })
})

//------------------------------------------------------------------
//                                PUT                 
// -----------------------------------------------------------------

route.put("/:NumPago",(req,res)=>{
    let NumPago = req.params.NumPago; 
    let Fecha = req.body.Fecha;
    let ModoDePago = req.body.ModoDePago;
    let IdUsuario = req.body.IdUsuario;
    let IdProducto = req.body.IdProducto;
    let sql = "call pppago (?, ?, ?, ?, ?)"
    conexion.query (sql,[NumPago, Fecha, ModoDePago, IdUsuario , IdProducto], function(err, result){
        if (err){
            res.json(err.message)
        }else{
            res.json("Modificacion realizada de manera exitosa")
        }
    })
})

//------------------------------------------------------------------
//                              DELETE                 
// -----------------------------------------------------------------

route.delete("/:NumPago",(req,res)=>{
    let NumPago = req.params.NumPago
    let sql = "Delete from pago where NumPago = ?"
    conexion.query (sql, [NumPago], function(error, result){
        if (error){
            throw error
        }else{
            res.send(result)
        } 
    })
})

module.exports = route;