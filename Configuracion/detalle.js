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
        conexion.query("Select * from detalle", (error,filas) => {
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
    let NumDetalle = 0; 
    let Cantidad = req.body.Cantidad;
    let PrecioUnitario = req.body.PrecioUnitario; 
    let IdProducto = req.body.IdProducto;
    let sql = "call ppdetalle (?, ?, ?, ?)"
    conexion.query (sql, [NumDetalle, Cantidad, PrecioUnitario, IdProducto], function(err, result){
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

route.put("/:NumDetalle",(req,res)=>{
    let NumDetalle = req.params.NumDetalle; 
    let Cantidad = req.body.Cantidad;
    let PrecioUnitario = req.body.PrecioUnitario;
    let IdProducto = req.body.IdProducto;
    let sql = "call ppdetalle (?, ?, ?, ?)"
    conexion.query (sql, [NumDetalle, Cantidad, PrecioUnitario, IdProducto], function(err, result){
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

route.delete("/:NumDetalle",(req,res)=>{
    let NumDetalle = req.params.NumDetalle
    let sql = "Delete from detalle where NumDetalle = ?"
    conexion.query (sql, [NumDetalle], function(error, result){
        if (error){
            throw error
        }else{
            res.send(result)
        } 
    })
})

module.exports = route;