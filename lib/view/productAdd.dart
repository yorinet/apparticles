import 'dart:convert';
import 'dart:io';

import 'package:appeasy/controller/categoryController.dart';
import 'package:appeasy/model/categoryModel.dart';
import 'package:appeasy/model/productModel.dart';
import 'package:appeasy/widget/wBox.dart';
import 'package:appeasy/widget/wTitle.dart';
import 'package:appeasy/widget/wTwoBox.dart';
import 'package:appeasy/widget/wtextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:appeasy/globals.dart' as globals;
import 'package:appeasy/controller/productController.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({super.key});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  TextEditingController idSelectController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController idCategoryController = TextEditingController();
  TextEditingController nameCategoryController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  TextEditingController referenceFrsController = TextEditingController();
  TextEditingController uniteController = TextEditingController();
  TextEditingController alertController = TextEditingController();
  TextEditingController prixVenteController = TextEditingController();
  TextEditingController tvaController = TextEditingController();
  TextEditingController imageProductController = TextEditingController();
  TextEditingController imageTextController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  var _valCategory;
  var _valUnite = "U";
  var _valTva = "20%";
  var _valAnnee = "2022";
  var _valCode = "";
  String getCode = "";
  var resultQrCode = "";
  var pickerSelect = "";
  File? _valImageProduct;
  File? _valImageProductText;
  final ImagePicker imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _getCategory();
  }

  final categoryController = CategoryController();
  void _getCategory() async {
    final result = await categoryController.getAll();
    setState(() {
      categoryList = result;
    });
  }

  List<CategoryModel> categoryList = [];

  bool isStock = false;
  void toggleStock() {
    setState(() {
      isStock = !isStock;
    });
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
                  text: 'Ajouter un produit',
                  weight: FontWeight.bold,
                  size: 14),
              WTitle(text: 'Remplir les champs', size: 12),
            ],
          )),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const WTitle(text: "Information de produit", spaceBottom: 10),
          WBox(
            widget: Expanded(
              child: WtextField(
                textHint: 'Designation',
                controller: designationController,
              ),
            ),
          ),
          WBox(
            widget: DropdownButton(
              elevation: 0,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down),
              iconSize: 35,
              style: const TextStyle(color: Colors.white),
              underline: const Divider(thickness: 0),
              hint: const Padding(
                padding: EdgeInsets.only(left: 13),
                child: Text("Categorie"),
              ),
              value: _valCategory,
              items: categoryList.map((namCategory) {
                return DropdownMenuItem(
                    value: namCategory.id,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: Text(namCategory.nameCategory!),
                    ));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _valCategory = value;
                });
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: WTwoBox(
                  widgetFirst: Expanded(
                    child: WtextField(
                        textHint: 'Reference', controller: referenceController),
                  ),
                  widgetLast: GestureDetector(
                      onTap: () {
                        scanBarcode();
                      },
                      child: const Icon(Icons.qr_code)),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: WBox(
                  widget: Expanded(
                    child: WtextField(
                      textHint: 'Reference Frs',
                      controller: referenceFrsController,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: WBox(
                  widget: DropdownButton(
                    elevation: 0,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconSize: 35,
                    style: const TextStyle(color: Colors.white),
                    underline: const Divider(thickness: 0),
                    hint: const Padding(
                      padding: EdgeInsets.only(left: 13),
                      child: Text("Unite"),
                    ),
                    value: _valUnite,
                    items: <String>['U', 'Cm', 'Kg', 'Lit']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 13),
                            child: Text(value),
                          ));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _valUnite = value!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: WBox(
                  widget: Expanded(
                    child: WtextField(
                      textHint: 'Alert Quantite',
                      controller: alertController,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    pickerSelect = "imgProduct";
                    showImage(context);
                  },
                  child: WBox(
                    height: 100,
                    widget: _valImageProduct != null
                        ? Image.file(_valImageProduct!,
                            filterQuality: FilterQuality.medium,
                            fit: BoxFit.cover,
                            width: double.infinity)
                        : const Image(
                            image:
                                AssetImage('assets/images/defaultProduct.jpg'),
                            filterQuality: FilterQuality.medium,
                            fit: BoxFit.cover,
                            width: double.infinity),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    pickerSelect = "imgProductText";
                    showImage(context);
                  },
                  child: WBox(
                    height: 100,
                    widget: _valImageProductText != null
                        ? Image.file(_valImageProductText!,
                            filterQuality: FilterQuality.medium,
                            fit: BoxFit.cover,
                            width: double.infinity)
                        : const Image(
                            image:
                                AssetImage('assets/images/defaultProduct.jpg'),
                            filterQuality: FilterQuality.medium,
                            fit: BoxFit.cover,
                            width: double.infinity),
                  ),
                ),
              ),
            ],
          ),
          const WTitle(
              text: "Gestion monitaire", spaceTop: 20, spaceBottom: 10),
          Row(
            children: [
              Expanded(
                child: WBox(
                  widget: Expanded(
                    child: WtextField(
                      textHint: 'Prix',
                      controller: prixVenteController,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: WBox(
                  widget: DropdownButton(
                    elevation: 0,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconSize: 35,
                    style: const TextStyle(color: Colors.white),
                    underline: const Divider(thickness: 0),
                    hint: const Padding(
                      padding: EdgeInsets.only(left: 13),
                      child: Text("TVA"),
                    ),
                    value: _valTva,
                    items: <String>['0%', '7%', '14%', '20%']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 13),
                            child: Text(value),
                          ));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _valTva = value!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Gestion d'inventaire"),
              Switch(
                value: isStock,
                onChanged: (value) {
                  setState(() {
                    isStock = value;
                  });
                },
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (isStock)
            Row(
              children: [
                Expanded(
                  child: WBox(
                    widget: Expanded(
                      child: WtextField(
                        textHint: 'Quantite',
                        controller: quantityController,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: WBox(
                    widget: DropdownButton(
                      elevation: 0,
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      iconSize: 35,
                      style: const TextStyle(color: Colors.white),
                      underline: const Divider(thickness: 0),
                      hint: const Padding(
                        padding: EdgeInsets.only(left: 13),
                        child: Text("Annee"),
                      ),
                      value: _valAnnee,
                      items: <String>['2022', '2023', '2024', '2025']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 13),
                              child: Text(value),
                            ));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _valAnnee = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 100),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 40,
        child: FloatingActionButton.extended(
            onPressed: () {
              submitData();
            },
            label: const Text('Enresistrer')),
      ),
    );
  }

  void showImage(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext buildCtx) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ListTile(
              leading: InkWell(
                onTap: () {
                  galleryImage();
                },
                child: const CircleAvatar(
                    child: Icon(
                  Icons.folder,
                )),
              ),
              trailing: InkWell(
                onTap: () {
                  cameraImage();
                },
                child: const CircleAvatar(
                    child: Icon(
                  Icons.camera,
                )),
              ),
              title: const Text(
                'Dossier - Camera',
                textAlign: TextAlign.center,
              ),
              subtitle: const Text("Source d'image",
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 12))),
        );
      },
    );
  }

// Barcode
  Future scanBarcode() async {
    getCode = await FlutterBarcodeScanner.scanBarcode(
        "#009922", "Cancel", true, true as ScanMode);
    setState(() {
      _valCode = getCode;
    });
  }

  // Submit Data
  Future<void> submitData() async {
    final body = {
      "designation": designationController.text,
      "idCategory": _valCategory,
      "reference": referenceController.text,
      "referenceFrs": referenceFrsController.text,
      "unite": _valUnite,
      "alert": alertController.text,
      "prixVente": prixVenteController.text,
      "tva": _valTva,
      "imageProduct": '',
      "imagetext": '',
      "idUser": 1,
    };
    const url = 'https://fine-gold-lion-boot.cyclic.app/product';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-type': 'application/json'},
    );
    if (response.statusCode == 200) {
      designationController.text = '';
      designationController.text = '';
      _valCategory = '';
      referenceController.text = '';
      referenceFrsController.text = '';
      _valUnite = '';
      alertController.text = '';
      prixVenteController.text = '';
      _valTva = '';
      successMessage('Creation Success');
    } else {
      errorMessage('Creation Failed');
    }
  }

  Future galleryImage() async {
    final XFile? _file =
        await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (_file != null) {
        if (pickerSelect == "imgProduct") {
          _valImageProduct = File(_file.path);
        } else {
          _valImageProductText = File(_file.path);
        }
      } else {
        print('No file');
      }
    });
  }

  Future cameraImage() async {
    final XFile? _file =
        await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (_file != null) {
        if (pickerSelect == "imgProduct") {
          _valImageProduct = File(_file.path);
        } else {
          _valImageProductText = File(_file.path);
        }
      } else {
        print('No file');
      }
    });
  }

  Future<void> scanbarCode() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          //.getBarcodeStreamReceiver(
          '#ff6666',
          'Cancel',
          true,
          ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed';
    }
    if (!mounted) return;
    setState(() {
      resultQrCode = barcodeScanRes;
    });
  }

  Future<void> scanQR() async {
    String qrcodeScanRes;
    try {
      qrcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      qrcodeScanRes = 'Failed';
    }
    if (!mounted) return;
    setState(() {
      resultQrCode = qrcodeScanRes;
    });
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
