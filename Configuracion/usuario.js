//------------------------------------------------------------------
//                   Importa lo que hay en Database.js                
// -----------------------------------------------------------------

const conexion = require ('../BD/Database.js')
const express = require('express');
const cors = require('cors');
const encrypt = require ('bcryptjs');
//const jwt = require ('jsonwebtoken');
//const {jwt_secret} = require ('../Rutas/parametros.js')


const app = express(); 
app.use(express.json());
app.use(cors());

const route = express.Router()


// //------------------------------------------------------------------
// //                   JWT SIGN Token a los usuarios              
// // -----------------------------------------------------------------

// route.post('/jwt',function(req,res) {
//     let data = NombreDeUsuario = req.body.NombreDeUsuario;
//     let sql = "Select NombreDeUsuario from usuario where NombreDeUsuario = ? "
//     conexion.query(sql, data, (error,filas) => {
//         if (error){
//             res.json("error")
//         }if(filas.length == 0) {
//             res.json('Usuario no encontrado')
//             return;
//         }
//         jwt.sign(data, jwt_secret, function (err, token){
//             if(err) {
//                 console.log("Error: " +err.message);
//             }else{
//                 res.json(token)
//             }
//         })
//     });
// });

// //------------------------------------------------------------------
// //                   JWT VERIFY Verificar el token              
// // -----------------------------------------------------------------

// route.post('/verify', function (req, res) { 
//     //let token = req.header('Authorization')
//     let token = req.get('Authorization')
    
//         jwt.verify(token, jwt_secret, function(err,datos){
//         if(err) {
//             res.json('Token no encontrado ... Ingrese un token porfavor :,v')
//         }else{
//             console.log("Los datos si coinciden ");
//             res.json(datos)
//         }
//     });
// });


//------------------------------------------------------------------
//                                GET                 
// -----------------------------------------------------------------

route.get("/",(req,res)=>{
        conexion.query("Select * from usuario", (error,filas) => {
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

// route.post("/", (req,res)=>{
//     let IdUsuario = 0; 
//     let NombreDeUsuario = req.body.NombreDeUsuario;
//     let Contraseña = req.body.Contraseña;
//     let IdCliente = req.body.IdCliente;
//     let sql = "call ppusuario (?, ?, ?, ?)"
//     conexion.query (sql, [IdUsuario, NombreDeUsuario, Contraseña, IdCliente], function(err, results){
//         if (err){
//             res.json(err.message)
//         }else{
//             res.json("Adicion realizada de manera exitosa")
//         }
//     })
// })

route.post('/',async function(req,res) {

    let clave_encriptada = await encrypt.hash(req.body.Contraseña,10)

    let data = {
        IdUsuario:req.params.IdUsuario,
        NombreDeUsuario:req.body.NombreDeUsuario,
        Contraseña:clave_encriptada,
        IdCliente:req.body.IdCliente,
        }
        
    let sql = 'Insert into usuario set ?';
    conexion.query(sql, data, function(err,results){
        if (err){
            res.json(err.message)
        }else{
            res.json("Adicion realizada de manera exitosa")
        }
    })
});

//------------------------------------------------------------------
//                                PUT                 
// -----------------------------------------------------------------

// route.put("/:IdUsuario",(req,res)=>{
//     let IdUsuario = req.params.IdUsuario; 
//     let NombreDeUsuario = req.body.NombreDeUsuario;
//     let Contraseña = req.body.Contraseña;
//     let IdCliente = req.body.IdCliente;
//     let sql = "call ppusuario (?, ?, ?, ?)"
//     conexion.query (sql, [IdUsuario, NombreDeUsuario, Contraseña, IdCliente], function(err, results){
//         if (err){
//             res.json(err.message)
//         }else{
//             res.json("Adicion realizada de manera exitosa")
//         }
//     })
// })

route.put('/:IdUsuario',async function(req,res) {

    let clave_encriptada = await encrypt.hash(req.body.Contraseña,10)

    let IdUsuario = req.params.IdUsuario; 
    let NombreDeUsuario = req.body.NombreDeUsuario;
    let Contraseña = clave_encriptada;
    let IdCliente = req.body.IdCliente;

    let sql = 'Update usuario set NombreDeUsuario = ?, Contraseña=?, IdCliente=? where IdUsuario = ?';

    conexion.query (sql, [NombreDeUsuario, Contraseña, IdCliente, IdUsuario], function(err, results){
        if (err){
            res.json(err.message)
        }else{
            res.json("Modificacion realizada de manera exitosa")
        }
    }) 
});

//------------------------------------------------------------------
//                              DELETE                 
// -----------------------------------------------------------------

route.delete("/:IdUsuario",(req,res)=>{
    let IdUsuario = req.params.IdUsuario
    let sql = "Delete from usuario where IdUsuario = ?"
    conexion.query (sql, [IdUsuario], function(error, result){
        if (error){
            throw error
        }else{
            res.send(result)
        } 
    })
})



module.exports = route;