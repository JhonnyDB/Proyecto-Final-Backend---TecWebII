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
//     let Contrase??a = req.body.Contrase??a;
//     let IdCliente = req.body.IdCliente;
//     let sql = "call ppusuario (?, ?, ?, ?)"
//     conexion.query (sql, [IdUsuario, NombreDeUsuario, Contrase??a, IdCliente], function(err, results){
//         if (err){
//             res.json(err.message)
//         }else{
//             res.json("Adicion realizada de manera exitosa")
//         }
//     })
// })

route.post('/', async function(req, res) {
    if (!req.body.NombreDeUsuario || !req.body.Contrase??a || !req.body.IdCliente) {
        res.json("No se permiten campos vac??os");
        return;
    }

    let clave_encriptada = await encrypt.hash(req.body.Contrase??a, 10)

    let nombreDeUsuario = req.body.NombreDeUsuario;
    let sql = 'SELECT COUNT(*) AS count FROM usuario WHERE NombreDeUsuario = ?';
    conexion.query(sql, nombreDeUsuario, function(err, results) {
        if (err) {
            res.json(err.message)
        } else {
            if (results[0].count > 0) {
                console.log("El Nombre de usuario ya existe");
                res.json("El nombre de usuario ya existe")
            } else {
                let data = {
                    IdUsuario: req.params.IdUsuario,
                    NombreDeUsuario: nombreDeUsuario,
                    Contrase??a: clave_encriptada,
                    IdCliente: req.body.IdCliente,
                }
                sql = 'INSERT INTO usuario SET ?';
                conexion.query(sql, data, function(err, results) {
                    if (err) {
                        res.json(err.message)
                    } else {
                        res.json("Adici??n realizada de manera exitosa")
                    }
                })
            }
        }
    })
});


//------------------------------------------------------------------
//                                PUT                 
// -----------------------------------------------------------------

// route.put("/:IdUsuario",(req,res)=>{
//     let IdUsuario = req.params.IdUsuario; 
//     let NombreDeUsuario = req.body.NombreDeUsuario;
//     let Contrase??a = req.body.Contrase??a;
//     let IdCliente = req.body.IdCliente;
//     let sql = "call ppusuario (?, ?, ?, ?)"
//     conexion.query (sql, [IdUsuario, NombreDeUsuario, Contrase??a, IdCliente], function(err, results){
//         if (err){
//             res.json(err.message)
//         }else{
//             res.json("Adicion realizada de manera exitosa")
//         }
//     })
// })

route.put('/:IdUsuario',async function(req,res) {

    let clave_encriptada = await encrypt.hash(req.body.Contrase??a,10)

    let IdUsuario = req.params.IdUsuario; 
    let NombreDeUsuario = req.body.NombreDeUsuario;
    let Contrase??a = clave_encriptada;
    let IdCliente = req.body.IdCliente;

    let sql = 'Update usuario set NombreDeUsuario = ?, Contrase??a=?, IdCliente=? where IdUsuario = ?';

    conexion.query (sql, [NombreDeUsuario, Contrase??a, IdCliente, IdUsuario], function(err, results){
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