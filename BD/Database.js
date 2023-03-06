
const mysql = require('mysql2');

//------------------------------------------------------------------
//                    Conexion con la BD                
// -----------------------------------------------------------------

const conexion = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '77438122',
    database: 'SistemaVenta2'
})

//------------------------------------------------------------------
//                    Mensaje de conexion                
// -----------------------------------------------------------------

conexion.connect(function(err) {
    if(err){
        throw err;
    }else{
        console.log('Conexion exitosa con la base de datos SistemaVenta2 !!!');
    }
});

//------------------------------------------------------------------
//                   Exporta lo que hay en Database.js                
// -----------------------------------------------------------------

module.exports = conexion