import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import '../model/category.dart';
import '../model/product-renter.dart';
import '/firebase_options.dart';
import 'package:sporent/screens/color.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final productNameController = TextEditingController();
  final productPriceController = TextEditingController();
  final productCategoryController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productPhotoController = TextEditingController();
  final productRentPriceController = TextEditingController();
  final productLocationController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> category() =>
      FirebaseFirestore.instance.collection("category").snapshots();

  File? image;
  String? productCategory;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future openGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(imagePicked!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Add Product"),
          ),
          backgroundColor: hexStringToColor("4164DE"),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: _size.height / 30, horizontal: _size.width / 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Product Photo",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: _size.height / 50),
                  Container(
                    width: _size.width / 5,
                    height: _size.height / 10,
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                width: 2, color: HexColor("868686")))),
                    child: TextButton(
                      onPressed: () async {
                        await openGallery();
                      },
                      child: image != null
                          ? Image.file(image!)
                          : FaIcon(
                              FontAwesomeIcons.plus,
                              color: HexColor("4164DE"),
                              size: 35,
                            ),
                    ),
                  ),
                  SizedBox(height: _size.height / 23),
                  const Text("Product Name",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  SizedBox(height: _size.height / 50),
                  TextField(
                    controller: productNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your name'),
                  ),
                  SizedBox(height: _size.height / 23),
                  const Text("Product Price",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  SizedBox(height: _size.height / 50),
                  TextField(
                    controller: productPriceController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your price'),
                  ),
                  SizedBox(height: _size.height / 23),
                  const Text("Rent Price",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  SizedBox(height: _size.height / 50),
                  TextField(
                    controller: productRentPriceController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your rent price'),
                  ),
                  SizedBox(height: _size.height / 23),
                  const Text("Product Category",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  SizedBox(height: _size.height / 50),
                  StreamBuilder(
                    stream: firestore.collection('category').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        List<DropdownMenuItem> categoryItem = [];
                        for (int i = 0; i < snapshot.data!.docs.length; i++) {
                          Category category = Category.fromDocument(
                              snapshot.data!.docs[i].id,
                              snapshot.data!.docs[i].data());
                          categoryItem.add(DropdownMenuItem(
                              value: category.id,
                              child: Text(category.olahraga.toString())));
                        }
                        return DropdownButtonFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Select category'),
                          items: categoryItem,
                          onChanged: (value) {
                            setState(() {
                              productCategory = value!;
                            });
                          },
                        );
                      }
                    },
                  ),
                  SizedBox(height: _size.height / 23),
                  const Text("Location",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  SizedBox(height: _size.height / 50),
                  TextField(
                    controller: productLocationController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your location'),
                  ),
                  SizedBox(height: _size.height / 23),
                  const Text("Product Description",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  SizedBox(height: _size.height / 50),
                  TextField(
                    controller: productDescriptionController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your description'),
                  ),
                  SizedBox(height: _size.height / 23),
                  SizedBox(
                      width: _size.width,
                      height: _size.height / 15,
                      child: ElevatedButton(
                        onPressed: () {
                          int price = int.parse(productPriceController.text);
                          int rent_price =
                              int.parse(productRentPriceController.text);

                          addProduct(
                              productImage: image,
                              productName: productNameController.text,
                              productPrice: price,
                              rentPrice: rent_price,
                              productCategory: productCategory,
                              productDescription:
                                  productDescriptionController.text);

                          var snackBar = SnackBar(
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.symmetric(vertical: _size.height/40, horizontal: _size.width/40),
                            content: SizedBox(
                                height: _size.height/20,
                                child: Padding(
                                  padding: EdgeInsets.only(top: _size.height/80),
                                  child: const Text('Sucess Add Product!',
                                      style: TextStyle(fontSize: 20)),
                                )),
                            duration: const Duration(seconds: 5),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor("4164DE"),
                          // padding: const EdgeInsets.only(right: 300, bottom: 40)
                        ),
                        child:
                            const Text("Confirm", textAlign: TextAlign.center),
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}

Future addProduct(
    {required File? productImage,
    required String productName,
    required int productPrice,
    required int rentPrice,
    required String? productCategory,
    required String productDescription}) async {
  final docProduct = FirebaseFirestore.instance.collection("product-renter").doc();

  final ref = FirebaseStorage.instance
      .ref()
      .child('product-images/')
      .child(docProduct.id);
  await ref.putFile(productImage!);
  String? imageUrl;
  imageUrl = await ref.getDownloadURL();

  var productRenter = ProductRenter(docProduct.id, imageUrl, productName, productPrice, rentPrice,
          productCategory, productDescription)
      .toJson();

  await docProduct.set(productRenter);
}
