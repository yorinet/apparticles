const dbConnect = require('../config');

var UserModel = function(product){
    this.name     = product.name;
    this.email      = product.email;
    this.password          = product.password;
  };
  
UserModel.getAll = function (result) {
    dbConnect.query("SELECT * FROM users ORDER BY id ASC", function (err, res) {
    if(err) { result(null, err) }
    else{ result(null, res) }
    });
};

UserModel.getById = function (id, result) {
    dbConnect.query("SELECT * FROM users WHERE id = ? ", id, function (err, res) {
    if(err) { result(err, null) }
    else{ result(null, res) }
    });
};

UserModel.create = function (body, result) {
    dbConnect.query("INSERT INTO users set ?", body, function (err, res) {
    if(err) { result(err, null) }
    else { result(null, res.insertId) }
    });
};

UserModel.delete = function(id, result){
    dbConnect.query("DELETE FROM users WHERE id = ?", [id], function (err, res) {
    if(err) { result(null, err) }
    else{ result(null, res) }
    });
};

UserModel.update = function(body, result) {
    const id = body.id;
    const name = body.content.name;
    const email = body.content.email;
    const password = body.content.password;
    dbConnect.query("UPDATE users SET name = ?, email = ?, password = ? WHERE id = ?", 
    [name, email, password, id], function (err, res) {
        if(err) { result(null, err) }
        else { result(null, res) }
    });
}


module.exports = UserModel;