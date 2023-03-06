//------------------------------------------------------------------
//                   Importa lo que hay en Database.js                
// -----------------------------------------------------------------

const conexion = require ('../BD/Database.js')
const express = require('express');
const cors = require('cors');
const fs = require('fs');
const path = require('path');
const multer = require('multer');

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, '../Imagenes')
    },
    filename: function (req, file, cb) {
        cb(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname))
    }
})

const upload = multer({ storage: storage });

const app = express();
app.use(express.json());
app.use(cors());

const route = express.Router()
//------------------------------------------------------------------
//                                GET                 
// -----------------------------------------------------------------

route.get("/", (req, res) => {
    const sql = "SELECT * FROM producto";
    conexion.query(sql, (error, resultados) => {
        if (error) {
            res.status(500).json({ error: "Error al obtener los productos" });
        } else {
        const productos = resultados.map((producto) => {
            return {
                IdProducto: producto.IdProducto,
                NombreProducto: producto.NombreProducto,
                Marca: producto.Marca,
                PrecioU: producto.PrecioU,
                Stock: producto.Stock,
                IdCategoria: producto.IdCategoria,
                Imagen: producto.Imagen,
                UrlImagen: `../../Proyecto Final/Imagenes/${producto.Imagen}`
            };
        });
        res.json(productos);
        }
    });
});

//------------------------------------------------------------------
//                                POST                 
// -----------------------------------------------------------------

route.post("/", upload.single('Imagen'), (req, res) => {
    let IdProducto = 0;
    let NombreProducto = req.body.NombreProducto;
    let Marca = req.body.Marca;
    let PrecioU = req.body.PrecioU;
    let Stock = req.body.Stock;
    let IdCategoria = req.body.IdCategoria;
    let Imagen = req.file ? req.file.filename : null;

    if (!NombreProducto || !Marca || !PrecioU || !Stock || !IdCategoria || !Imagen) {
        return res.status(400).json({ error: "Los campos NombreProducto, Marca, PrecioU, Stock, IdCategoria y la imagen son obligatorios" });
    }

    let sql = "CALL ppproducto (?, ?, ?, ?, ?, ?, ?)";
    conexion.query(sql, [IdProducto, NombreProducto, Marca, PrecioU, Stock, IdCategoria, Imagen], function(err, result){
        if (err){
            res.status(500).json({ error: err.message });
        } else {
            res.json("Adición realizada de manera exitosa");
        }
    });
});



//------------------------------------------------------------------
//                                PUT                 
// -----------------------------------------------------------------

route.put("/:IdProducto", upload.single('Imagen'), (req, res) => {
    const IdProducto = req.params.IdProducto;
    const NombreProducto = req.body.NombreProducto;
    const Marca = req.body.Marca;
    const PrecioU = req.body.PrecioU;
    const Stock = req.body.Stock;
    const IdCategoria = req.body.IdCategoria;
    const Imagen = req.file ? req.file.filename : null;

    const sqlSelectImagen = "SELECT Imagen FROM producto WHERE IdProducto = ?";
    conexion.query(sqlSelectImagen, [IdProducto], (error, results) => {
        if (error) {
            console.error(error);
            res.status(500).json({ error: "Error al obtener la imagen del producto." });
            return;
        }

        const imagenAnterior = results[0].Imagen;

        const sqlUpdateProducto = "UPDATE producto SET NombreProducto = ?, Marca = ?, PrecioU = ?, Stock = ?, IdCategoria = ?, Imagen = ? WHERE IdProducto = ?";
        conexion.query(sqlUpdateProducto, [NombreProducto, Marca, PrecioU, Stock, IdCategoria, Imagen, IdProducto], (error, results) => {
            if (error) {
                console.error(error);
                res.status(500).json({ error: "Error al actualizar el producto." });
                return;
            }

            if (Imagen && imagenAnterior) {
                const filePath = path.join(__dirname, "../Imagenes", imagenAnterior);
                fs.unlink(filePath, (err) => {
                    if (err) {
                        console.error(err);
                        res.status(500).json({ error: "Error al eliminar la imagen anterior." });
                        return;
                    }

                    res.json({ message: "Producto actualizado correctamente." });
                });
            } else {
                res.json({ message: "Producto actualizado correctamente." });
            }
        });
    });
});

//------------------------------------------------------------------
//                              DELETE                 
// -----------------------------------------------------------------

route.delete("/:IdProducto", (req, res) => {
    const IdProducto = req.params.IdProducto;

    const sqlSelectImagen = "SELECT Imagen FROM producto WHERE IdProducto = ?";
    conexion.query(sqlSelectImagen, [IdProducto], (error, results) => {
        if (error) {
        console.error(error);
        res.status(500).json({ error: "Error al obtener la imagen del producto." });
        return;
        }
    const imagen = results[0].Imagen;
    
    const sqlDeleteProducto = "DELETE FROM producto WHERE IdProducto = ?";
    conexion.query(sqlDeleteProducto, [IdProducto], (error, results) => {
        if (error) {
            console.error(error);
            res.status(500).json({ error: "Error al eliminar el producto." });
            return;
        }

        const filePath = path.join(__dirname, "../Imagenes", imagen);
        if (fs.existsSync(filePath)) {
                fs.unlink(filePath, (err) => {
            if (err) {
                console.error(err);
                res.status(500).json({ error: "Error al eliminar la imagen." });
                return;
            }

            res.json({ message: "Producto eliminado correctamente." });
            });
            } else {
            res.json({ message: "Producto eliminado correctamente. La imagen no existe." });
        }
        });
    });
});

module.exports = route;