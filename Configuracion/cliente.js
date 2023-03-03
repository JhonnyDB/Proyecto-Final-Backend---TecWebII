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
        conexion.query("Select * from cliente", (error,filas) => {
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

route.post("/", (req,res)=>{
    let IdCliente = 0; 
    let NombreCliente = req.body.NombreCliente;
    let ApellidoCliente = req.body.ApellidoCliente;
    let Direccion = req.body.Direccion;
    let FechaNacimiento = req.body.FechaNacimiento;
    let Celular = req.body.Celular;
    let Email = req.body.Email;
    let Pais = req.body.Pais;
    let Ciudad = req.body.Ciudad;
    let sql = "call ppcliente (?, ?, ?, ?, ?, ?, ?, ?, ?)"
    conexion.query (sql, [IdCliente, NombreCliente, ApellidoCliente, Direccion, FechaNacimiento, Celular, Email, Pais, Ciudad], function(err, results){
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

route.put("/:IdCliente",function (req,res){
    let IdCliente = req.params.IdCliente; 
    let NombreCliente = req.body.NombreCliente;
    let ApellidoCliente = req.body.ApellidoCliente;
    let Direccion = req.body.Direccion;
    let FechaNacimiento = req.body.FechaNacimiento;
    let Celular = req.body.Celular;
    let Email = req.body.Email;
    let Pais = req.body.Pais;
    let Ciudad = req.body.Ciudad;
    let sql = "call ppcliente (?, ?, ?, ?, ?, ?, ?, ?, ?)"
    conexion.query (sql, [IdCliente, NombreCliente, ApellidoCliente, Direccion, FechaNacimiento, Celular, Email, Pais, Ciudad], function(err, results){
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

route.delete("/:IdCliente",(req,res)=>{
    let IdCliente = req.params.IdCliente
    let sql = "Delete from cliente where IdCliente = ?"
    conexion.query (sql, [IdCliente], function(error, result){
        if (error){
            throw error
        }else{
            res.send(result)
        } 
    })
})

module.exports = route;