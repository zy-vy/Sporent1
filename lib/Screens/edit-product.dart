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

class EditProduct extends StatefulWidget {
  final String productId;
  const EditProduct(this.productId, {super.key});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
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
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("product")
                .doc(widget.productId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              var docProduct = snapshot.data;
              productNameController.text = docProduct!.get('productName');
              productPriceController.text =
                  docProduct.get('productPrice').toString();
              productDescriptionController.text =
                  docProduct.get('productDescription');
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30, left: 20, right: 35, bottom: 35),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                                child: Text(
                              "Product Photo",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            )),
                            TextButton(
                                onPressed: () async {
                                  await openGallery();
                                },
                                child: const Text("Add Photo")),
                          ],
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
                            child: image != null
                                ? Image.file(image!)
                                : Image.network(
                                    docProduct.get('productImage'))),
                        const SizedBox(height: 40),
                        const Text("Product Name",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 20),
                        TextField(
                          controller: productNameController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter your name'),
                        ),
                        const SizedBox(height: 40),
                        const Text("Product Price",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
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
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 20),
                        DropdownButtonFormField(
                          value: docProduct.get('productCategory'),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Select category'),
                          items: const [
                            DropdownMenuItem(
                                value: "Male", child: Text("Male")),
                            DropdownMenuItem(
                                value: "Female", child: Text("Female"))
                          ],
                          onChanged: (value) {
                            productCategory = value as String?;

                            FirebaseFirestore.instance
                                .collection('product')
                                .doc(widget.productId)
                                .update({'productCategory': productCategory});
                          },
                        ),
                        const SizedBox(height: 40),
                        const Text("Product Description",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
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
                              onPressed: () async {
                                final String newName =
                                    productNameController.text;
                                final int newPrice =
                                    int.parse(productPriceController.text);
                                final String newDescription =
                                    productDescriptionController.text;

                                if (image != null) {
                                  FirebaseStorage.instance
                                      .refFromURL(
                                          docProduct.get('productImage'))
                                      .delete();

                                  final ref = FirebaseStorage.instance
                                      .ref()
                                      .child('product-images/')
                                      .child(widget.productId);
                                  await ref.putFile(image!);
                                  String? imageUrl;
                                  imageUrl = await ref.getDownloadURL();

                                  FirebaseFirestore.instance
                                      .collection("product")
                                      .doc(widget.productId)
                                      .update({
                                    "productName": newName,
                                    "productPrice": newPrice,
                                    "productDescription": newDescription,
                                    "productImage": imageUrl
                                  });
                                } else {
                                  FirebaseFirestore.instance
                                      .collection("product")
                                      .doc(widget.productId)
                                      .update({
                                    "productName": newName,
                                    "productPrice": newPrice,
                                    "productDescription": newDescription,
                                  });
                                }

                                const snackBar = SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.all(8),
                                  content: SizedBox(
                                    height: 50,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text('Sucess Update Product!', style: TextStyle(fontSize: 20)),
                                    )),
                                  duration: Duration(seconds: 5),
                                  );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: HexColor("4164DE"),
                              ),
                              child: const Text("Confirm",
                                  textAlign: TextAlign.center),
                            )),
                      ],
                    ),
                  ),
                ],
              );
            }));
  }
}

showSuccess(BuildContext context) {
  AlertDialog alert = AlertDialog(
    contentPadding:
        const EdgeInsets.only(left: 22, right: 22, top: 12, bottom: 12),
    alignment: Alignment.center,
    title: const Center(
      child: Text(
        "Sucess Update Product",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    ),
    content: Text(
      "Success to Update Product",
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w400, color: HexColor("979797")),
    ),
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}
