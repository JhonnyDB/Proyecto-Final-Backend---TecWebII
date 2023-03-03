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
        conexion.query("Select * from categoria", (error,filas) => {
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
    let IdCategoria = 0; 
    let DescripcionCategoria = req.body.DescripcionCategoria;
    let sql = "call ppcategoria (?, ?)"
    conexion.query (sql, [IdCategoria, DescripcionCategoria], function(err, result){
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

route.put("/:IdCategoria",(req,res)=>{
    let IdCategoria = req.params.IdCategoria; 
    let DescripcionCategoria = req.body.DescripcionCategoria;
    let sql = "call ppcategoria (?, ?)"
    conexion.query (sql, [IdCategoria, DescripcionCategoria], function(err, result){
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

route.delete("/:IdCategoria",(req,res)=>{
    let IdCategoria = req.params.IdCategoria
    let sql = "Delete from categoria where IdCategoria = ?"
    conexion.query (sql, [IdCategoria], function(error, result){
        if (error){
            throw error
        }else{
            res.send(result)
        } 
    })
})

module.exports = route;