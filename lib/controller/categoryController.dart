import 'dart:convert';
import 'package:appeasy/model/categoryModel.dart';
import 'package:http/http.dart' as http;
import 'package:appeasy/globals.dart' as globals;

class CategoryController {
  Future<List<CategoryModel>> getAll() async {
    const url = 'https://fine-gold-lion-boot.cyclic.app/category';
    final uri = Uri.parse(url);
    //var url = Uri.http(globals.urlApi, '/category');
    final response = await http.get(uri);

    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    List<CategoryModel> array = [];

    List<dynamic> data = jsonDecode(response.body);
    for (var i = 0; i < data.length; i++) {
      array.add(CategoryModel.fromJson(data[i]));
    }

    return array;
  }
}
