import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import '../model/category.dart';
import '../model/product-renter.dart';
import 'package:sporent/screens/color.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();
  final photoController = TextEditingController();
  final locationController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> category() =>
      FirebaseFirestore.instance.collection("category").snapshots();

  File? image;
  File? image_temp;
  List<File?> listImages = [];
  String? productCategory;
  int counter = 1;
  int deleteCount = 1;

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
    listImages.add(image_temp);

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Add Product"),
          ),
          backgroundColor: hexStringToColor("4164DE"),
        ),
        resizeToAvoidBottomInset: true,
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: _size.height / 30, horizontal: _size.width / 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Product Photo (Maximum 3 Photo)",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: _size.height / 50),
                  Row(
                    children: [
                      for (int i = 0; i < counter; i++)
                        Stack(
                          children: [
                                Container(
                                  width: _size.width / 5,
                                  height: _size.height / 10,
                                  decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(
                                              width: 2,
                                              color: HexColor("868686")))),
                                  child: TextButton(
                                    onPressed: () async {
                                      await openGallery();
                                      setState(() {
                                        if (counter != 3) {
                                          counter += 1;
                                          deleteCount += 1;
                                        }
                                        listImages.remove(image_temp);
                                        listImages.add(image);
                                      });
                                    },
                                    child: listImages[i] != null
                                        ? Image.file(listImages[i]!)
                                        : FaIcon(
                                            FontAwesomeIcons.plus,
                                            color: HexColor("4164DE"),
                                            size: 35,
                                          ),
                                  ),
                                ),
                                counter != 1
                                    ? SizedBox(width: _size.width / 20)
                                    : const SizedBox(),
                            counter != 1
                                ? Positioned(
                                    right: _size.width / 25,
                                    child: Container(
                                        height: 25,
                                        width: 25,
                                        decoration: const BoxDecoration(
                                            color: Colors.blueAccent,
                                            shape: BoxShape.circle),
                                        child: IconButton(
                                          icon: const FaIcon(
                                              FontAwesomeIcons.xmark,
                                              size: 10,
                                              color: Colors.white),
                                          onPressed: () {},
                                        )),
                                  )
                                : const Positioned(
                                    right: 0, top: 0, child: SizedBox())
                          ],
                        )
                    ],
                  ),
                  SizedBox(height: _size.height / 23),
                  fieldText("Product Name", "Enter product name", _size,
                      nameController),
                  fieldPrice("Product Price", "Enter product price", _size,
                      priceController),
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
                  fieldText("Location", "Enter product location", _size,
                      locationController),
                  fieldText("Product Description", "Enter product description",
                      _size, descriptionController),
                  SizedBox(
                      width: _size.width,
                      height: _size.height / 15,
                      child: ElevatedButton(
                        onPressed: () {
                          int price = int.parse(priceController.text);

                          addProduct(
                              image: image,
                              name: nameController.text,
                              price: price,
                              location: locationController.text,
                              category: productCategory,
                              description: descriptionController.text);

                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackbar(_size));

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
    {required File? image,
    required String name,
    required int price,
    required String? location,
    required String? category,
    required String description}) async {
  final docProduct =
      FirebaseFirestore.instance.collection("product-renter").doc();

  final categoryReference =
      FirebaseFirestore.instance.collection("category").doc(category);

  final ref = FirebaseStorage.instance
      .ref()
      .child('product-images/')
      .child(docProduct.id);
  await ref.putFile(image!);

  var productRenter = ProductRenter(docProduct.id, docProduct.id, name, price,
          location, categoryReference, description)
      .toJson();

  await docProduct.set(productRenter);
}

Column fieldText(String title, String desc, Size _size,
        TextEditingController controller) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        SizedBox(height: _size.height / 50),
        TextField(
          controller: controller,
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 5,
          decoration: InputDecoration(
              border: const OutlineInputBorder(), labelText: desc),
        ),
        SizedBox(height: _size.height / 23),
      ],
    );

Column fieldPrice(String title, String desc, Size _size,
        TextEditingController controller) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        SizedBox(height: _size.height / 50),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
              border: const OutlineInputBorder(), labelText: desc),
        ),
        SizedBox(height: _size.height / 23),
      ],
    );

SnackBar snackbar(Size _size) => SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(
          vertical: _size.height / 40, horizontal: _size.width / 40),
      content: SizedBox(
          height: _size.height / 20,
          child: Padding(
            padding: EdgeInsets.only(top: _size.height / 80),
            child: const Text('Sucess Add Product!',
                style: TextStyle(fontSize: 20)),
          )),
      duration: const Duration(seconds: 5),
    );
