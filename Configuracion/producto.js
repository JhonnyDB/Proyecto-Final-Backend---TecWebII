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
        conexion.query("Select * from producto", (error,filas) => {
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
    let IdProducto = 0; 
    let NombreProducto = req.body.NombreProducto;
    let Marca = req.body.Marca;
    let PrecioU = req.body.PrecioU;
    let Stock = req.body.Stock;
    let IdCategoria = req.body.IdCategoria;
    let sql = "call ppproducto (?, ?, ?, ?, ?, ?)"
    conexion.query (sql, [IdProducto, NombreProducto, Marca, PrecioU, Stock, IdCategoria], function(err, result){
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

route.put("/:IdProducto",(req,res)=>{
    let IdProducto = req.params.IdProducto; 
    let NombreProducto = req.body.NombreProducto;
    let Marca = req.body.Marca;
    let PrecioU = req.body.PrecioU;
    let Stock = req.body.Stock;
    let IdCategoria = req.body.IdCategoria;
    let sql = "call ppproducto (?, ?, ?, ?, ?, ?)"
    conexion.query (sql, [IdProducto, NombreProducto, Marca, PrecioU, Stock, IdCategoria], function(err, result){
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

route.delete("/:IdProducto",(req,res)=>{
    let IdProducto = req.params.IdProducto
    let sql = "Delete from producto where IdProducto = ?"
    conexion.query (sql, [IdProducto], function(error, result){
        if (error){
            throw error
        }else{
            res.send(result)
        } 
    })
})

module.exports = route;