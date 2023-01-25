import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sporent/component/firebase_image.dart';
import '../model/category.dart';
import 'package:sporent/screens/color.dart';

import '../model/subcategory.dart';

class EditProduct extends StatefulWidget {
  const EditProduct(this.productId, {super.key});

  final String productId;

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
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
  int temp = 0;
  bool haveData = true;
  DocumentReference<Map<String, dynamic>>? referenceCategory;

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
            child: const Text("Edit Product"),
          ),
          backgroundColor: hexStringToColor("4164DE"),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("product")
                .doc(widget.productId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var docProduct = snapshot.data;
                if (temp == 0) {
                  nameController.text = docProduct!.get('name');
                  priceController.text =
                      docProduct.get('rent_price').toString();
                  descriptionController.text = docProduct.get('description');
                  locationController.text = docProduct.get('location');
                  depositController.text =
                      docProduct['deposit_price'].toString();
                  DocumentReference categoryReference =
                      firestore.doc(docProduct.get('category').toString());
                  var currentCategory =
                      categoryReference.id.replaceAll(')', '');
                  referenceCategory = FirebaseFirestore.instance
                      .collection("category")
                      .doc(currentCategory);
                  DocumentReference subcategoryReference =
                      firestore.doc(docProduct.get('subcategory').toString());
                  productSubcategory =
                      subcategoryReference.id.replaceAll(')', '');
                  temp += 1;
                }
                return ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: _size.height / 30,
                          horizontal: _size.width / 18),
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
                                  child: const Text("Change Photo")),
                            ],
                          ),
                          photo(_size, image, docProduct),
                          fieldText("Product Name", "Enter product name", _size,
                              nameController),
                          fieldPrice("Product Price", "Enter product price",
                              _size, priceController),
                          fieldPrice("Deposit Price", "Enter deposit price",
                              _size, depositController),
                          const Text("Product Category",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          SizedBox(height: _size.height / 50),
                          StreamBuilder(
                            stream:
                                firestore.collection('category').snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                List<DropdownMenuItem> categoryItem = [];
                                DocumentReference categoryReference =
                                    firestore.doc(
                                        docProduct!.get('category').toString());
                                var currentCategory =
                                    categoryReference.id.replaceAll(')', '');
                                for (int i = 0;
                                    i < snapshot.data!.docs.length;
                                    i++) {
                                  Category category = Category.fromDocument(
                                      snapshot.data!.docs[i].id,
                                      snapshot.data!.docs[i].data());
                                  categoryItem.add(DropdownMenuItem(
                                      value: category.id,
                                      child:
                                          Text(category.olahraga.toString())));
                                }
                                return DropdownButtonFormField(
                                  value: currentCategory,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Select category'),
                                  items: categoryItem,
                                  onChanged: (value) {
                                    setState(() {
                                      productCategory = value!;
                                      referenceCategory = FirebaseFirestore
                                          .instance
                                          .collection("category")
                                          .doc(productCategory);
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
                                return DropdownButtonFormField(
                                    value: haveData == false
                                        ? null
                                        : productSubcategory,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Select subcategory'),
                                    items: subcategoryItem,
                                    onChanged: (value) => setState(() {
                                          productSubcategory = value!;
                                          haveData = true;
                                        }));
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
                          confirmButton(
                              _size,
                              widget.productId,
                              image,
                              docProduct,
                              productCategory,
                              productSubcategory,
                              nameController,
                              priceController,
                              depositController,
                              descriptionController,
                              locationController,
                              context)
                        ],
                      ),
                    ),
                  ],
                );
              }
            }));
  }
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

SizedBox confirmButton(
        Size _size,
        String id,
        File? image,
        DocumentSnapshot<Map<String, dynamic>>? docProduct,
        String? productCategory,
        String? productSubcategory,
        TextEditingController name,
        TextEditingController price,
        TextEditingController deposit,
        TextEditingController description,
        TextEditingController location,
        BuildContext context) =>
    SizedBox(
        width: _size.width,
        height: _size.height / 15,
        child: ElevatedButton(
          onPressed: () async {
            final categoryReference = FirebaseFirestore.instance
                .collection("category")
                .doc(productCategory);

            final subcategoryReference = FirebaseFirestore.instance
                .collection("subcategory")
                .doc(productSubcategory);

            if (image != null) {
              FirebaseStorage.instance
                  .refFromURL(docProduct!.get('img'))
                  .delete();

              final ref = FirebaseStorage.instance
                  .ref()
                  .child('product-images/')
                  .child(id);
              await ref.putFile(image);

              final String link = await ref.getDownloadURL();

              if (productCategory != null && productSubcategory != null) {
                FirebaseFirestore.instance
                    .collection("product")
                    .doc(id)
                    .update({
                  "name": name.text,
                  "rent_price": int.parse(price.text),
                  "deposit_price": int.parse(deposit.text),
                  "description": description.text,
                  "location": location.text,
                  "category": categoryReference,
                  "subcategory": subcategoryReference,
                  "img": link
                });
              }
              if (productCategory == null && productSubcategory != null) {
                FirebaseFirestore.instance
                    .collection("product")
                    .doc(id)
                    .update({
                  "name": name.text,
                  "rent_price": int.parse(price.text),
                  "deposit_price": int.parse(deposit.text),
                  "description": description.text,
                  "location": location.text,
                  "subcategory": subcategoryReference,
                  "img": link
                });
              }

              if (productCategory != null && productSubcategory == null) {
                FirebaseFirestore.instance
                    .collection("product")
                    .doc(id)
                    .update({
                  "name": name.text,
                  "rent_price": int.parse(price.text),
                  "deposit_price": int.parse(deposit.text),
                  "description": description.text,
                  "location": location.text,
                  "category": categoryReference,
                  "img": link
                });
              }

              if (productCategory == null && productSubcategory == null) {
                FirebaseFirestore.instance
                    .collection("product")
                    .doc(id)
                    .update({
                  "name": name.text,
                  "rent_price": int.parse(price.text),
                  "deposit_price": int.parse(deposit.text),
                  "description": description.text,
                  "location": location.text,
                  "img": link
                });
              }
            } else {
              if (productCategory != null && productSubcategory != null) {
                FirebaseFirestore.instance
                    .collection("product")
                    .doc(id)
                    .update({
                  "name": name.text,
                  "rent_price": int.parse(price.text),
                  "deposit_price": int.parse(deposit.text),
                  "description": description.text,
                  "location": location.text,
                  "category": categoryReference,
                  "subcategory": subcategoryReference,
                });
              }
              if (productCategory == null && productSubcategory != null) {
                FirebaseFirestore.instance
                    .collection("product")
                    .doc(id)
                    .update({
                  "name": name.text,
                  "rent_price": int.parse(price.text),
                  "deposit_price": int.parse(deposit.text),
                  "description": description.text,
                  "location": location.text,
                  "subcategory": subcategoryReference,
                });
              }

              if (productCategory != null && productSubcategory == null) {
                FirebaseFirestore.instance
                    .collection("product")
                    .doc(id)
                    .update({
                  "name": name.text,
                  "rent_price": int.parse(price.text),
                  "deposit_price": int.parse(deposit.text),
                  "description": description.text,
                  "location": location.text,
                  "category": categoryReference,
                });
              }

              if (productCategory == null && productSubcategory == null) {
                FirebaseFirestore.instance
                    .collection("product")
                    .doc(id)
                    .update({
                  "name": name.text,
                  "rent_price": int.parse(price.text),
                  "deposit_price": int.parse(deposit.text),
                  "description": description.text,
                  "location": location.text,
                });
              }
            }

            CoolAlert.show(
                    context: context,
                    type: CoolAlertType.success,
                    text: "Success edit product....")
                .then((value) => Navigator.pop(context));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: HexColor("4164DE"),
          ),
          child: const Text("Update", textAlign: TextAlign.center),
        ));

Column photo(Size _size, File? image,
        DocumentSnapshot<Map<String, dynamic>>? docProduct) =>
    Column(
      children: [
        SizedBox(height: _size.height / 50),
        Container(
            width: _size.width / 5,
            height: _size.height / 10,
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 2, color: HexColor("868686")))),
            child: image != null
                ? Image.file(image)
                : CachedNetworkImage(
                    imageUrl: docProduct!.get("img"),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator())),
        SizedBox(height: _size.height / 23),
      ],
    );
