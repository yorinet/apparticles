const dbConnect = require('../config');

var ProductModel = function(product){
    this.id             = product.id;
    this.designation    = product.designation;
    this.idCategory     = product.idCategory;
    this.reference      = product.reference;
    this.referenceFrs   = product.referenceFrs;
    this.unite          = product.unite;
    this.alert          = product.alert;
    this.prixVente      = product.prixVente;
    this.tva            = product.tva;
    this.imageProduct   = product.imageProduct;
    this.imageText      = product.imageText;
    this.idUser         = product.idUser;
  };
  
  ProductModel.getAll = function (result) {
    dbConnect.query("SELECT *, category.nameCategory FROM products, category WHERE products.idCategory = category.id", function (err, res) {
    if(err) { result(null, err) }
    else{ result(null, res) }
    });
};
/*
ProductModel.getAll = function (result) {
    dbConnect.query("SELECT * FROM products", function (error, response) {
    if(error) { (null, error) }
    else{ result(null, response) }
    });
};
*/
ProductModel.getById = function (id, result) {
    dbConnect.query("SELECT * FROM products WHERE id = ? ", id, function (err, res) {
    if(err) { result(err, null) }
    else{ result(null, res) }
    });
};

ProductModel.create = function (body, result) {
    dbConnect.query("INSERT INTO products set ?", body, function (err, res) {
    if(err) { result(err, null) }
    else { result(null, res.insertId) }
    });
};

ProductModel.delete = function(id, result){
    dbConnect.query("DELETE FROM products WHERE id = ?", [id], function (err, res) {
    if(err) { result(null, err) }
    else{ result(null, res) }
    });
};

ProductModel.update = function(body, result) {
    const id = body.id;
    const designation = body.content.designation;
    const idCategory = body.content.idCategory;
    const reference = body.content.reference;
    const referenceFrs = body.content.referenceFrs;
    const unite = body.content.unite;
    const alert = body.content.alert;
    const prixVente = body.content.prixVente;
    const tva = body.content.tva;
    const imageProduct = body.content.imageProduct;
    const imageText = body.content.imageText;
    const idUser = body.content.idUser;
    dbConnect.query("UPDATE products SET designation = ?, idCategory = ?, reference = ?, referenceFrs = ?, unite = ?, alert = ?, prixVente = ?, tva = ?, imageProduct = ?, imageText = ?, idUser = ? WHERE id = ?", 
    [designation, idCategory, reference, referenceFrs, unite, alert, prixVente, tva, imageProduct, imageText, idUser,id], function (err, res) {
        if(err) { result(null, err) }
        else { result(null, res) }
    });
}


module.exports = ProductModel;