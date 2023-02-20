import 'dart:convert';
import 'package:appeasy/model/productModel.dart';
import 'package:http/http.dart' as http;

class ProductController {
  Future<List<ProductModel>> getAll() async {
    const url = 'https://fine-gold-lion-boot.cyclic.app/product';
    final uri = Uri.parse(url);
    //var url = Uri.http('https://fine-gold-lion-boot.cyclic.app', '/product');
    final response = await http.get(uri);

    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    List<ProductModel> array = [];

    List<dynamic> data = jsonDecode(response.body);
    for (var i = 0; i < data.length; i++) {
      array.add(ProductModel.fromJson(data[i]));
    }

    return array;
  }
}
