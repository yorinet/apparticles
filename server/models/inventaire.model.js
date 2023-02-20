const dbConnect = require('../config');

var InventairetModel = function(inventaire){
    this.id             = inventaire.id;
    this.annee          = inventaire.annee;
    this.idProduct      = inventaire.idProduct;
    this.quantity       = inventaire.quantity;
    this.idUser         = inventaire.idUser;
  };

InventairetModel.getAll = function (result) {
    dbConnect.query("SELECT *, products.designation FROM inventaire, products WHERE inventaire.idProduct = products.id", function (error, response) {
    if(error) { (null, error) }
    else{ result(null, response) }
    });
};

InventairetModel.getById = function (id, result) {
    dbConnect.query("SELECT * FROM inventaire WHERE id = ? ", id, function (err, res) {
    if(err) { result(err, null) }
    else{ result(null, res) }
    });
};

InventairetModel.create = function (body, result) {
    dbConnect.query("INSERT INTO inventaire set ?", body, function (err, res) {
    if(err) { result(err, null) }
    else { result(null, res.insertId) }
    });
};

InventairetModel.delete = function(id, result){
    dbConnect.query("DELETE FROM inventaire WHERE id = ?", [id], function (err, res) {
    if(err) { result(null, err) }
    else{ result(null, res) }
    });
};

InventairetModel.update = function(body, result) {
    const id = body.id;
    const designation = body.content.nameinventaire;
    const idinventaire = body.content.image;
    dbConnect.query("UPDATE inventaire SET nameinventaire = ?, image = ? WHERE id = ?", 
    [nameinventaire, image,id], function (err, res) {
        if(err) { result(null, err) }
        else { result(null, res) }
    });
}


module.exports = InventairetModel;