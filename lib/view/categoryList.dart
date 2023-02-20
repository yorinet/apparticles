import 'package:appeasy/controller/categoryController.dart';
import 'package:appeasy/model/categoryModel.dart';
import 'package:appeasy/widget/wTitle.dart';
import 'package:flutter/material.dart';
import 'package:appeasy/route.dart' as route;

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<CategoryModel> categoryUi = [];
  final categoryController = CategoryController();

  void _getCategorys() async {
    final result = await categoryController.getAll();
    setState(() {
      categoryUi = result;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCategorys();
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
                  text: 'Listes des categorie',
                  weight: FontWeight.bold,
                  size: 14),
              WTitle(text: 'Tous les categories enregistrer', size: 12),
            ],
          )),
      body: (categoryUi.isEmpty)
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: categoryUi.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final categoryItem = categoryUi[index];
                final id = categoryItem.id;
                return Card(
                  child: Row(
                    children: [
                      const SizedBox(
                          width: 60, child: Center(child: Text('1'))),
                      Expanded(
                        child: ListTile(
                          title: WTitle(
                              text: categoryItem.nameCategory!,
                              weight: FontWeight.bold),
                          subtitle: WTitle(
                              text: categoryItem.nameCategory!,
                              size: 12,
                              weight: FontWeight.normal),
                          trailing: PopupMenuButton(
                            onSelected: (value) {
                              if (value == 'edit') {
                              } else if (value == 'delete') {
                                showMessageDelete(context);
                              }
                            },
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
                onTap: () {},
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
              subtitle: const Text('Cet categorie vas etre supprimer',
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 12))),
        );
      },
    );
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
                      title: Text('Nouvelle categorie'),
                      subtitle: Text('Ajouter une categorie',
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
                      subtitle: Text("Retourner a la page d'acceuil",
                          style: TextStyle(fontSize: 12))),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
