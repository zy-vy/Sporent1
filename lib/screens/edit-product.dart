import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sporent/component/firebase_image.dart';
import '../model/category.dart';
import 'package:sporent/screens/color.dart';

class EditProduct extends StatefulWidget {
  final String productId;
  const EditProduct(this.productId, {super.key});

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
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> category() =>
      FirebaseFirestore.instance.collection("category").snapshots();

  File? image;
  String? productCategory;
  int temp = 0;

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
                .collection("product-renter")
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
                  priceController.text = docProduct.get('price').toString();
                  descriptionController.text = docProduct.get('description');
                  locationController.text = docProduct.get('location');
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
                                    });
                                  },
                                );
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
                              nameController,
                              priceController,
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

SnackBar snackbar(Size _size) => SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(
          vertical: _size.height / 40, horizontal: _size.width / 40),
      content: SizedBox(
          height: _size.height / 20,
          child: Padding(
            padding: EdgeInsets.only(top: _size.height / 80),
            child: const Text('Sucess Update Product!',
                style: TextStyle(fontSize: 20)),
          )),
      duration: const Duration(seconds: 5),
    );

SizedBox confirmButton(
        Size _size,
        String id,
        File? image,
        DocumentSnapshot<Map<String, dynamic>>? docProduct,
        String? productCategory,
        TextEditingController name,
        TextEditingController price,
        TextEditingController description,
        TextEditingController location,
        BuildContext context) =>
    SizedBox(
        width: _size.width,
        height: _size.height / 15,
        child: ElevatedButton(
          onPressed: () async {
            final categoryReference = FirebaseFirestore.instance.collection("category").doc(productCategory);

            if (image != null) {
              FirebaseStorage.instance
                  .refFromURL(docProduct!.get('image'))
                  .delete();

              final ref = FirebaseStorage.instance
                  .ref()
                  .child('product-images/')
                  .child(id);
              await ref.putFile(image);

              if (productCategory != null) {
                FirebaseFirestore.instance
                    .collection("product-renter")
                    .doc(id)
                    .update({
                  "name": name.text,
                  "price": int.parse(price.text),
                  "description": description.text,
                  "location": location.text,
                  "category": categoryReference,
                  "image": id
                });
              } else {
                FirebaseFirestore.instance
                    .collection("product-renter")
                    .doc(id)
                    .update({
                  "name": name.text,
                  "price": int.parse(price.text),
                  "description": description.text,
                  "location": location.text,
                  "image": id
                });
              }
            } else {
              if (productCategory != null) {
                FirebaseFirestore.instance
                    .collection("product-renter")
                    .doc(id)
                    .update({
                  "name": name.text,
                  "price": int.parse(price.text),
                  "description": description.text,
                  "location": location.text,
                  "category": categoryReference,
                });
              } else {
                FirebaseFirestore.instance
                    .collection("product-renter")
                    .doc(id)
                    .update({
                  "name": name.text,
                  "price": int.parse(price.text),
                  "description": description.text,
                  "location": location.text,
                });
              }
            }

            ScaffoldMessenger.of(context).showSnackBar(snackbar(_size));

            Navigator.pop(context);
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
                : FirebaseImage(
                    filePath: "product-images/${docProduct!.get('id')}")),
        SizedBox(height: _size.height / 23),
      ],
    );
