import 'package:appeasy/controller/inventaireController.dart';
import 'package:appeasy/model/inventaireModel.dart';
import 'package:appeasy/widget/wTitle.dart';
import 'package:flutter/material.dart';
import 'package:appeasy/route.dart' as route;

class InventaireList extends StatefulWidget {
  const InventaireList({super.key});

  @override
  State<InventaireList> createState() => _InventaireListState();
}

class _InventaireListState extends State<InventaireList> {
  List<InventaireModel> inventaireUi = [];
  final inventaireController = InventaireController();

  void _getInventaire() async {
    final result = await inventaireController.getAll();
    setState(() {
      inventaireUi = result;
    });
  }

  @override
  void initState() {
    super.initState();
    _getInventaire();
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
                  text: "Liste d'inventaires",
                  weight: FontWeight.bold,
                  size: 14),
              WTitle(text: "Tous les inventaires", size: 12),
            ],
          )),
      body: (inventaireUi.isEmpty)
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: inventaireUi.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final product = inventaireUi[index];
                final id = product.id;
                return Card(
                  child: Row(
                    children: [
                      const SizedBox(
                          width: 60, child: Center(child: Text('1'))),
                      Expanded(
                        child: ListTile(
                          title: WTitle(
                              text: product.designation!,
                              weight: FontWeight.bold),
                          subtitle: WTitle(
                              text: product.annee!,
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
              trailing: const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.close,
                  )),
              title: const Text(
                'Attention!',
                textAlign: TextAlign.center,
              ),
              subtitle: const Text('Ce produit vas etre suppriver',
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
                  Navigator.pushNamedAndRemoveUntil(
                      context, route.dashboard, (route) => false);
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
}
