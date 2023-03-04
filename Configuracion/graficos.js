const express = require('express');
const conexion = require('../BD/Database');
const route= express.Router();

route.get('/', (req, res) => {

    let sql = 'SELECT producto.NombreProducto, detalle.Cantidad FROM producto, detalle WHERE detalle.IdProducto = producto.IdProducto ORDER BY detalle.Cantidad DESC;';

        conexion.query(sql, (error, results) => {
        if (error) throw error;
        res.send(results);
    });
});


module.exports=route