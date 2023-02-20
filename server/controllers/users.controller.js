const UserModel = require('../models/users.model');

exports.getAll = async function(request, response) {
    await UserModel.getAll(function(error, result) {
      if (error) { response.send(error) }
      else { response.send(result); }
    });
};

exports.getById = async function(request, response) {
    await UserModel.getById(request.params.id, function(error, result) {
      if (error) { response.send(err) }
      else { response.json(result) }
    });
};

exports.create = async function(request, response) {
  const body = request.body;
  if(body.constructor === Object && Object.keys(body).length === 0){
    response.status(400).send({ error:true, message: 'Please provide all required field' });
  } else {
    await UserModel.create(body, function(error, result) {
        if (error) { response.send(error) }
        else { response.json({ error:false, message: 'Added successfully',data:body }) }
    });
  }
}

exports.delete = async function(request, response) {
    const id = request.params.id;
    await UserModel.delete(id, function(error, result) {
      if (error) { response.send(err) }
      else { response.json({ error:false, message: 'Deleted successfully' }) }
    });
};

exports.update = async function(request, response) {
  let body = {
    id: request.params.id,
    content: request.body,
  } 
  if(body.constructor === Object && Object.keys(body).length === 0){
    response.status(400).send({ error:true, message: 'Please provide all required field' });
  } else {
    await UserModel.update(body, function(err, result) {
        if (err) { response.send(err) }
        else { response.json({ error:false, message: 'Update successfully' }) }
    });
  }
}
