import 'package:appeasy/view/categoryList.dart';
import 'package:appeasy/view/dashboard.dart';
import 'package:appeasy/view/inventaireList.dart';
import 'package:appeasy/view/productList.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = [
    Dashboard(),
    ProductList(),
    CategoryList(),
    InventaireList(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.amber),
            label: 'Home',
            activeIcon: Icon(Icons.home, color: Colors.red),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.square, color: Colors.amber),
            label: 'Produits',
            activeIcon: Icon(Icons.square, color: Colors.red),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list, color: Colors.amber),
            label: 'Categories',
            activeIcon: Icon(Icons.list, color: Colors.red),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate, color: Colors.amber),
            label: 'Inventaire',
            activeIcon: Icon(Icons.calculate, color: Colors.red),
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
