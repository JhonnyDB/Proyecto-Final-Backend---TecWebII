const conexion = require ('../BD/Database.js')
const express = require('express');
const cors = require('cors');
const bcrypt = require ('bcrypt');
const jwt = require ('jsonwebtoken');
const {jwt_secret} = require ('../Rutas/parametros.js')

const app = express();
app.use(express.json());
app.use(cors());

const route = express.Router()

// //------------------------------------------------------------------
// //                   JWT SIGN Token a los usuarios              
// // -----------------------------------------------------------------

route.post('/', (req, res) => {
    const nombreDeUsuario = req.body.NombreDeUsuario;
    const contraseña = req.body.Contraseña;
    const sql = "SELECT NombreDeUsuario, Contraseña FROM usuario WHERE NombreDeUsuario = ?";

    conexion.query(sql, [nombreDeUsuario], (error, filas) => {
        if (error) {
            console.error(error);
            res.status(500).json({ error: 'Error en la base de datos' });
            return;
        }

        if (filas.length === 0) {
            console.log('Credenciales inválidas');
            res.status(401).json({ error: 'Credenciales inválidas' });
            return;
        }

        const hash = filas[0].Contraseña;
        bcrypt.compare(contraseña, hash, (err, result) => {
            if (err || !result) {
                console.log('Credenciales inválidas');
                res.status(401).json({ error: 'Credenciales inválidas' });
                return;
            }

            const payload = { nombreDeUsuario };
            jwt.sign(payload, jwt_secret, (err, token) => {
                if (err) {
                    console.error(err);
                    res.status(500).json({ error: 'Error al generar el token' });
                    return;
                }
                console.log(`El token del usuario ${nombreDeUsuario} es: ${token}`);
                res.json({ token });
            });
        });
    });
});

// route.post('/',function(req,res) {
//     let data = {
//         NombreDeUsuario:req.body.NombreDeUsuario,
//         Contraseña:req.body.Contraseña,
//         }

//         let sql = 'Select NombreDeUsuario, Contraseña from usuario where NombreDeUsuario = ? and Contraseña = ?';

//         conexion.query( sql, req.body.NombreDeUsuario, (err,resul) =>{
//             if (err) {
//                 resul.json('ERROR')
//             }else{    
//                 conexion.query( sql, req.body.NombreDeUsuario, async function(err,resul){
//                     let ClaveBD = resul[0].clave;
//                     let valido = await encrypt.compare(req.body.Contraseña, ClaveBD);
//                     console.log(valido);
//                     if(valido){
//                         console.log('los datos si coinciden')
//                         //res.json('.3.');
//                     }else{
//                         console.log('los datos no coinciden')
//                         //res.json('.>.')
//                     }
//                 });
//             }

//         jwt.sign(data, jwt_secret, function (err, token){
//             if(err) {
//                 console.log("Error: " +err.message);
//             }else{
//                 res.json(token)
//             }
//         })
//     });
// });


module.exports = route;