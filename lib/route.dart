import 'package:appeasy/view/categoryList.dart';
import 'package:appeasy/view/dashboard.dart';
import 'package:appeasy/view/home.dart';
import 'package:appeasy/view/inventaireList.dart';
import 'package:appeasy/view/loginPage.dart';
import 'package:appeasy/view/productAdd.dart';
import 'package:flutter/material.dart';
import 'package:appeasy/view/productList.dart';

// Route Names
const String loginPage = 'loginPage';
const String dashboard = 'dashboard';
const String productList = 'productList';
const String productAdd = 'productAdd';
const String categoryList = 'categoryList';
const String inventaireList = 'inventaireList';
const String home = 'home';

// Control our page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    /*case productList:
      return MaterialPageRoute(
          builder: (context) => ProductList(arguments: settings.arguments));*/
    case loginPage:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case dashboard:
      return MaterialPageRoute(builder: (context) => const Dashboard());
    case productList:
      return MaterialPageRoute(builder: (context) => const ProductList());
    case productAdd:
      return MaterialPageRoute(builder: (context) => const ProductAdd());
    case categoryList:
      return MaterialPageRoute(builder: (context) => const CategoryList());
    case inventaireList:
      return MaterialPageRoute(builder: (context) => const InventaireList());
    case home:
      return MaterialPageRoute(builder: (context) => const Home());
    default:
      throw ('This route name does not exit');
  }
}
