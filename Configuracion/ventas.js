//------------------------------------------------------------------
//                   Importa lo que hay en Database.js                
// -----------------------------------------------------------------

const conexion = require ('../BD/Database.js')
const express = require('express');
const cors = require('cors');

const route = express.Router()


route.post('/',async function (req, res){

    try { 
        const { fechaoper, id_persona, usuario, detalles } = req.body; 
        await conexion.promise().beginTransaction(); 
        const resultVenta = await conexion.promise().query( 
        'INSERT INTO tventa (fechaoper, id_persona, usuario) VALUES (?, ?, ?)', 
        [fechaoper, id_persona, usuario] 
        ); 
        const id_venta = resultVenta[0].insertId; 
        for (const detalle of detalles) { 
            await conexion.promise().query( 
            'INSERT INTO tventa_det (id_venta, id_producto, precio, cantidad, descuento) VALUES (?, ?, ?, ?, ?)', 
            [id_venta, detalle.id_producto, detalle.precio, detalle.cantidad, detalle.descuento] 
            ); 
        } 
        await conexion.promise().commit(); 
        res.json({ 
        message: 'Venta insertada correctamente', 
        id_venta: id_venta 
        }); 
    } catch (error) { 
        await conexion.promise().rollback(); 
        console.log(error); 
        res.status(500).json({ 
            message: 'Error al insertar la venta' 
        }); 
    } 
});

module.exports = route;