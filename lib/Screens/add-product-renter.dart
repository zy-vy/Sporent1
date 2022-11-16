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
import '/firebase_options.dart';
import 'package:skripsi_sporent/Screens/color.dart';

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
              padding: const EdgeInsets.only(
                  top: 30, left: 20, right: 35, bottom: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Product Photo",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 80,
                    height: 85,
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
                  const SizedBox(height: 40),
                  const Text("Product Name",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 20),
                  TextField(
                    controller: productNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your name'),
                  ),
                  const SizedBox(height: 40),
                  const Text("Product Price",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 40),
                  const Text("Product Category",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 20),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Select category'),
                    items: const [
                      DropdownMenuItem(value: "Male", child: Text("Male")),
                      DropdownMenuItem(value: "Female", child: Text("Female"))
                    ],
                    onChanged: (value) {
                      setState(() {
                        productCategory = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 40),
                  const Text("Product Description",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 20),
                  TextField(
                    controller: productDescriptionController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your description'),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                      width: 370,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          int price = int.parse(productPriceController.text);
                          addProduct(
                              productImage: image,
                              productName: productNameController.text,
                              productPrice: price,
                              productCategory: productCategory,
                              productDescription:
                                  productDescriptionController.text);
                                  
                          const snackBar = SnackBar(
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(8),
                            content: SizedBox(
                                height: 50,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text('Sucess Update Product!',
                                      style: TextStyle(fontSize: 20)),
                                )),
                            duration: Duration(seconds: 5),
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
    required String? productCategory,
    required String productDescription}) async {
  final docProduct = FirebaseFirestore.instance.collection("product").doc();

  String nameImage = docProduct.id;

  final ref =
      FirebaseStorage.instance.ref().child('product-images/').child(nameImage);
  await ref.putFile(productImage!);
  String? imageUrl;
  imageUrl = await ref.getDownloadURL();

  final json = {
    'id': docProduct.id,
    'productImage': imageUrl,
    'productName': productName,
    'productPrice': productPrice,
    'productCategory': productCategory,
    'productDescription': productDescription
  };

  await docProduct.set(json);
}
