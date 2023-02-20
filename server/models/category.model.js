const dbConnect = require('../config');

var CategorytModel = function(product){
    this.id             = product.id;
    this.nameCategory    = product.nameCategory;
    this.image       = product.image;
  };
  


CategorytModel.getAll = function (result) {
    dbConnect.query("SELECT * FROM category", function (error, response) {
    if(error) { (null, error) }
    else{ result(null, response) }
    });
};

CategorytModel.getById = function (id, result) {
    dbConnect.query("SELECT * FROM category WHERE id = ? ", id, function (err, res) {
    if(err) { result(err, null) }
    else{ result(null, res) }
    });
};

CategorytModel.create = function (body, result) {
    dbConnect.query("INSERT INTO category set ?", body, function (err, res) {
    if(err) { result(err, null) }
    else { result(null, res.insertId) }
    });
};

CategorytModel.delete = function(id, result){
    dbConnect.query("DELETE FROM category WHERE id = ?", [id], function (err, res) {
    if(err) { result(null, err) }
    else{ result(null, res) }
    });
};

CategorytModel.update = function(body, result) {
    const id = body.id;
    const designation = body.content.nameCategory;
    const idCategory = body.content.image;
    dbConnect.query("UPDATE category SET nameCategory = ?, image = ? WHERE id = ?", 
    [nameCategory, image,id], function (err, res) {
        if(err) { result(null, err) }
        else { result(null, res) }
    });
}


module.exports = CategorytModel;