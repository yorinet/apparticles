import 'dart:convert';
import 'package:appeasy/model/inventaireModel.dart';
import 'package:http/http.dart' as http;

class InventaireController {
  Future<List<InventaireModel>> getAll() async {
    var url = Uri.http('127.0.0.1:3000', '/inventaire');
    final response = await http.get(url);

    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    List<InventaireModel> array = [];

    List<dynamic> data = jsonDecode(response.body);
    for (var i = 0; i < data.length; i++) {
      array.add(InventaireModel.fromJson(data[i]));
    }

    return array;
  }
}
