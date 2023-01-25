import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sporent/component/firebase_image.dart';

import '../model/product.dart';
import '../screens/edit_product.dart';

class ProductCardRenter extends StatelessWidget {
  const ProductCardRenter(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    Reference firebase = FirebaseStorage.instance.ref();
    Size _size = MediaQuery.of(context).size;
    NumberFormat currencyFormatter =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: _size.height / 50),
      child: Container(
          decoration: BoxDecoration(color: HexColor("F5F5F5")),
          child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: _size.width / 20, horizontal: _size.height / 50),
              child: Row(
                children: [
                  CachedNetworkImage(
                      height: _size.height / 8,
                      width: _size.width / 5,
                      imageUrl: product.img!,
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator()),
                  SizedBox(width: _size.width / 60),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name!,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal)),
                      SizedBox(height: _size.height / 70),
                      Text(
                          "${currencyFormatter.format(product.rent_price)}/Day",
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ],
                  )),
                  SizedBox(width: _size.width / 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: _size.width / 5,
                        height: _size.height / 30,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    EditProduct(product.id!)));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: HexColor("4164DE")),
                          child: const Text("Edit",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(height: _size.height / 40),
                      SizedBox(
                        width: _size.width / 5,
                        height: _size.height / 30,
                        child: ElevatedButton(
                          onPressed: () {
                            showDeleteButton(context, product.id!);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: HexColor("4164DE")),
                          child: const Text("Delete",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      )
                    ],
                  )
                ],
              ))),
    );
  }
}

showDeleteButton(BuildContext context, String id) {
  Size _size = MediaQuery.of(context).size;

  Widget confirmButton = SizedBox(
    width: _size.width,
    height: _size.height / 20,
    child: ElevatedButton(
      onPressed: () {
        final product = FirebaseFirestore.instance
            .collection('product-renter')
            .doc(id)
            .delete();

        final ref = FirebaseStorage.instance
            .ref()
            .child('product-images/')
            .child(id)
            .delete();

        Navigator.of(context).pop();
      },
      style: ElevatedButton.styleFrom(backgroundColor: HexColor("4164DE")),
      child: const Text("Confirm",
          style: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
    ),
  );

  Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(
        "Cancel",
        style: TextStyle(
            fontSize: 16,
            color: HexColor("747272"),
            fontWeight: FontWeight.bold),
      ));

  AlertDialog alert = AlertDialog(
    contentPadding: EdgeInsets.symmetric(
        vertical: _size.height / 70, horizontal: _size.width / 20),
    alignment: Alignment.center,
    title: const Center(
      child: Text(
        "Delete Product?",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    ),
    content: Text(
      "Are you sure want to delete product?",
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w400, color: HexColor("979797")),
    ),
    actions: [
      Column(
        children: [confirmButton, cancelButton],
      )
    ],
    actionsAlignment: MainAxisAlignment.spaceAround,
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}
