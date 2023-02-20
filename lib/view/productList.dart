import 'package:appeasy/controller/productController.dart';
import 'package:appeasy/model/productModel.dart';
import 'package:appeasy/widget/wTitle.dart';
import 'package:flutter/material.dart';
import 'package:appeasy/route.dart' as route;
import 'package:http/http.dart' as http;
import 'package:appeasy/globals.dart' as globals;

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<ProductModel> productsUi = [];
  final productController = ProductController();
  bool isLoading = true;
  int idSelect = 0;
  void _getProducts() async {
    final result = await productController.getAll();
    setState(() {
      productsUi = result;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          iconTheme: const IconThemeData(size: 22),
          leadingWidth: 25,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              WTitle(
                  text: 'Listes des produis',
                  weight: FontWeight.bold,
                  size: 14),
              WTitle(text: 'Tous les produits enregistrer', size: 12),
            ],
          )),
      body: ListView.builder(
        //productsUi.isEmpty)
        itemCount: productsUi.length,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final product = productsUi[index];
          final id = product.id;
          return Card(
            child: Row(
              children: [
                const SizedBox(width: 60, child: Center(child: Text('1'))),
                Expanded(
                  child: ListTile(
                    title: WTitle(
                        text: product.designation!, weight: FontWeight.bold),
                    subtitle: WTitle(
                        text: product.nameCategory!,
                        size: 12,
                        weight: FontWeight.normal),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(
                              value: 'edit',
                              child: WTitle(text: 'Modifier', size: 13)),
                          const PopupMenuItem(
                              value: 'delete',
                              child: WTitle(text: 'Supprimer', size: 13)),
                        ];
                      },
                      onSelected: (value) {
                        if (value == 'edit') {
                          setState(() {
                            globals.idProduct = product.id!;
                            Navigator.pushNamed(context, route.productAdd);
                          });
                        } else if (value == 'delete') {
                          showMessageDelete(context);
                          setState(() {
                            idSelect = product.id!;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: SizedBox(
        height: 40,
        child: FloatingActionButton(
            onPressed: () {
              showMenu(context);
            },
            child: const Icon(Icons.apps)),
      ),
    );
  }

  void showMessageDelete(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext buildCtx) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ListTile(
              leading: InkWell(
                onTap: () {
                  deleteData(idSelect);
                },
                child: const CircleAvatar(
                    child: Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
              ),
              trailing: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.close,
                    )),
              ),
              title: const Text(
                'Attention!',
                textAlign: TextAlign.center,
              ),
              subtitle: const Text('Ce produit vas etre supprimer',
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 12))),
        );
      },
    );
  }

// Delete Item
  Future<void> deleteData(int idSelect) async {
    final url = 'https://fine-gold-lion-boot.cyclic.app/product/$idSelect';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      final filtered =
          productsUi.where((element) => element.id != idSelect).toList();
      setState(() {
        productsUi = filtered;
      });
      successMessage('Delete success');
    } else {
      errorMessage('Delete Failed');
    }
  }

  void showMenu(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext buildCtx) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, route.productAdd);
                },
                child: const Card(
                  child: ListTile(
                      trailing: CircleAvatar(child: Icon(Icons.add)),
                      title: Text('Nouveau produit'),
                      subtitle: Text('Ajouter un produit',
                          style: TextStyle(fontSize: 12))),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, route.home, (route) => false);
                },
                child: const Card(
                  child: ListTile(
                      trailing: CircleAvatar(child: Icon(Icons.home)),
                      title: Text('Dashboard'),
                      subtitle: Text("retourner a la page d'acceuil",
                          style: TextStyle(fontSize: 12))),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void successMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void errorMessage(String message) {
    final snackBar = SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
