class InventaireModel {
  int? id;
  String? annee;
  int? idProduct;
  int? quantity;
  int? idUser;
  String? designation;

  InventaireModel({
    this.id,
    this.idProduct,
    this.annee,
    this.quantity,
    this.idUser,
    this.designation,
  });

  InventaireModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    annee = json['annee'];
    idProduct = json['idProduct'];
    quantity = json['quantity'];
    idUser = json['idUser'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['annee'] = this.annee;
    data['idProduct'] = this.idProduct;
    data['quantity'] = this.quantity;
    data['idUser'] = this.idUser;
    data['designation'] = this.designation;

    return data;
  }
}
