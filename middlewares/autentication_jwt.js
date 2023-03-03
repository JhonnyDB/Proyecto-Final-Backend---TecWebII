const {jwt_secret} = require ('../Rutas/parametros.js')
const jwt = require ('jsonwebtoken');

//------------------------------------------------------------------
//                      Autenticacion del token               
// -----------------------------------------------------------------


const autenticacion_jwt = function(req, res, next){

        let token = req.get('Authorization')

        jwt.verify(token, jwt_secret, function(err,datos){
        if(err) {
            res.json('Token no encontrado ... Ingrese un token porfavor :,v')
        }else{
            next()
        }
    });
}

module.exports = autenticacion_jwt