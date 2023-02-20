class CategoryModel {
  int? id;
  String? nameCategory;
  String? image;

  CategoryModel({
    this.id,
    this.nameCategory,
    this.image,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameCategory = json['nameCategory'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nameCategory'] = this.nameCategory;
    data['image'] = this.image;

    return data;
  }
}
