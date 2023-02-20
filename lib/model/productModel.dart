class ProductModel {
  int? id;
  String? designation;
  int? idCategory;
  String? reference;
  String? referenceFrs;
  String? unite;
  String? alert;
  String? prixVente;
  String? tva;
  String? imageProduct;
  String? imageText;
  int? idUser;
  String? nameCategory;

  ProductModel({
    this.id,
    this.designation,
    this.idCategory,
    this.reference,
    this.referenceFrs,
    this.unite,
    this.alert,
    this.prixVente,
    this.tva,
    this.imageProduct,
    this.imageText,
    this.idUser,
    this.nameCategory,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    designation = json['designation'];
    idCategory = json['idCategory'];
    reference = json['reference'];
    referenceFrs = json['referenceFrs'];
    unite = json['unite'];
    alert = json['alert'];
    prixVente = json['prixVente'];
    tva = json['tva'];
    imageProduct = json['imageProduct'];
    imageText = json['imageText'];
    idUser = json['idUser'];
    nameCategory = json['nameCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['designation'] = this.designation;
    data['idCategory'] = this.idCategory;
    data['reference'] = this.reference;
    data['referenceFrs'] = this.referenceFrs;
    data['unite'] = this.unite;
    data['alert'] = this.alert;
    data['prixVente'] = this.prixVente;
    data['tva'] = this.tva;
    data['imageProduct'] = this.imageProduct;
    data['imageText'] = this.imageText;
    data['idUser'] = this.idUser;
    data['nameCategory'] = this.nameCategory;

    return data;
  }
}
