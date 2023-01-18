import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sporent/model/subcategory.dart';
import '../model/category.dart';
import 'package:sporent/screens/color.dart';

import '../model/product.dart';

class AddProduct extends StatefulWidget {
  const AddProduct(this.id, {super.key});

  final String? id;

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
  final depositController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> category() =>
      FirebaseFirestore.instance.collection("category").snapshots();

  File? image;
  String? productCategory;
  String? productSubcategory;
  bool enabled = false;
  bool haveData = false;
  bool haveImage = false;
  List<File?> listImages = [];
  DocumentReference<Map<String, dynamic>>? referenceCategory;
  final _formKey = GlobalKey<FormState>();

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
        resizeToAvoidBottomInset: true,
        body: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: _size.height / 30,
                      horizontal: _size.width / 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Product Photo",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: _size.height / 50),
                      Stack(children: [
                        Container(
                          width: _size.width / 5,
                          height: _size.height / 10,
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: haveImage == true
                                      ? const BorderSide(
                                          width: 2, color: Colors.red)
                                      : BorderSide(
                                          width: 2,
                                          color: HexColor("868686")))),
                          child: TextButton(
                            onPressed: () async {
                              await openGallery();
                              haveImage = false;
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
                        image != null
                            ? Positioned(
                                right: 0,
                                child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                        color: haveImage == true
                                            ? Colors.red
                                            : Colors.blueAccent,
                                        shape: BoxShape.circle),
                                    child: IconButton(
                                      icon: const FaIcon(FontAwesomeIcons.xmark,
                                          size: 10, color: Colors.white),
                                      onPressed: () {
                                        setState(() {
                                          image = null;
                                        });
                                      },
                                    )),
                              )
                            : const Positioned(
                                right: 0, top: 0, child: SizedBox())
                      ]),
                      haveImage == true
                          ? Column(
                              children: [
                                SizedBox(height: _size.height / 80),
                                const Text(
                                  "Image must not be empty",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 13),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      SizedBox(height: _size.height / 23),
                      fieldText("Product Name", "Enter product name", _size,
                          nameController),
                      fieldPrice("Product Price", "Enter product price", _size,
                          priceController),
                      fieldPrice("Deposit Price", "Enter deposit price", _size,
                          depositController),
                      const Text("Product Category",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
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
                            for (int i = 0;
                                i < snapshot.data!.docs.length;
                                i++) {
                              Category category = Category.fromDocument(
                                  snapshot.data!.docs[i].id,
                                  snapshot.data!.docs[i].data());
                              categoryItem.add(DropdownMenuItem(
                                  value: category.id,
                                  child: Text(category.olahraga.toString())));
                            }
                            return DropdownButtonFormField(
                              value: productCategory,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Select category'),
                              items: categoryItem,
                              validator: (value) {
                                if (value == null) {
                                  return "Category must not be empty";
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  productCategory = value!;
                                  referenceCategory = firestore
                                      .collection("category")
                                      .doc(productCategory);
                                  enabled = true;
                                  haveData = false;
                                });
                              },
                            );
                          }
                        },
                      ),
                      SizedBox(height: _size.height / 23),
                      const Text("Product Subcategory",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      SizedBox(height: _size.height / 50),
                      StreamBuilder(
                        stream: firestore
                            .collection('subcategory')
                            .where('category', isEqualTo: referenceCategory)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            List<DropdownMenuItem> subcategoryItem = [];
                            for (int i = 0;
                                i < snapshot.data!.docs.length;
                                i++) {
                              Subcategory subcategory =
                                  Subcategory.fromDocument(
                                      snapshot.data!.docs[i].data());
                              subcategoryItem.add(DropdownMenuItem(
                                  value: snapshot.data!.docs[i].id,
                                  child: Text(subcategory.type)));
                            }
                            return enabled == true
                                ? DropdownButtonFormField(
                                    value: haveData == false
                                        ? null
                                        : productSubcategory,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Select subcategory'),
                                    items: subcategoryItem,
                                    validator: (value) {
                                      if (value == null) {
                                        return "Subcategory must not be empty";
                                      }
                                    },
                                    onChanged: (value) => setState(() {
                                          productSubcategory = value!;
                                          haveData = true;
                                        }))
                                : DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Select subcategory'),
                                    items: subcategoryItem,
                                    onChanged: null);
                          }
                        },
                      ),
                      SizedBox(height: _size.height / 23),
                      fieldText("Location", "Enter product location", _size,
                          locationController),
                      fieldText(
                          "Product Description",
                          "Enter product description",
                          _size,
                          descriptionController),
                      SizedBox(
                          width: _size.width,
                          height: _size.height / 15,
                          child: ElevatedButton(
                            onPressed: () {
                              if (image == null) {
                                setState(() {
                                  haveImage = true;
                                });
                              }
                              if (_formKey.currentState!.validate()) {
                                int price = int.parse(priceController.text);
                                int deposit = int.parse(depositController.text);

                                addProduct(
                                    image: image,
                                    name: nameController.text,
                                    price: price,
                                    deposit: deposit,
                                    location: locationController.text,
                                    owner: widget.id,
                                    category: productCategory,
                                    subcategory: productSubcategory,
                                    description: descriptionController.text);

                                ScaffoldMessenger.of(context).showSnackBar(
                                    snackbar(_size, "Sucess Add Product!"));

                                Navigator.pop(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: HexColor("4164DE"),
                              // padding: const EdgeInsets.only(right: 300, bottom: 40)
                            ),
                            child: const Text("Confirm",
                                textAlign: TextAlign.center),
                          )),
                    ],
                  ),
                ),
              ],
            )));
  }
}

Future addProduct(
    {required File? image,
    required String name,
    required int price,
    required int deposit,
    required String? location,
    required String? owner,
    required String? category,
    required String? subcategory,
    required String description}) async {
  final docProduct = FirebaseFirestore.instance.collection("product").doc();

  final categoryReference =
      FirebaseFirestore.instance.collection("category").doc(category);

  final subcategoryReference =
      FirebaseFirestore.instance.collection("subcategory").doc(subcategory);

  final ownerReference =
      FirebaseFirestore.instance.collection("user").doc(owner);

  final ref = FirebaseStorage.instance
      .ref()
      .child('product-images/')
      .child(docProduct.id);
  await ref.putFile(image!);

  var productRenter = Product(
          docProduct.id,
          docProduct.id,
          name,
          price,
          deposit,
          location,
          ownerReference,
          categoryReference,
          subcategoryReference,
          description)
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
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 5,
          decoration: InputDecoration(
              border: const OutlineInputBorder(), labelText: desc),
          validator: (value) {
            if (value!.isEmpty) {
              return "$title must not be empty";
            }
            if (value.length < 5) {
              return "$title must more than 5 characters";
            }
          },
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
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
              border: const OutlineInputBorder(), labelText: desc),
          validator: (value) {
            if (value!.isEmpty) {
              return "$title must not be empty";
            }
          },
        ),
        SizedBox(height: _size.height / 23),
      ],
    );

SnackBar snackbar(Size _size, String text) => SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(
          vertical: _size.height / 40, horizontal: _size.width / 40),
      content: SizedBox(
          height: _size.height / 20,
          child: Padding(
            padding: EdgeInsets.only(top: _size.height / 80),
            child: Text(text, style: const TextStyle(fontSize: 20)),
          )),
      duration: const Duration(seconds: 5),
    );
