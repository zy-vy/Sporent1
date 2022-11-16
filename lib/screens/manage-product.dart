import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/screens/add-product-renter.dart';
import 'package:sporent/screens/edit-product.dart';
import '/firebase_options.dart';
import 'package:sporent/screens/color.dart';

class ManageProduct extends StatelessWidget {
  const ManageProduct({super.key});
  Stream<QuerySnapshot> product() =>
      FirebaseFirestore.instance.collection("product").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Edit Name"),
          ),
          backgroundColor: hexStringToColor("4164DE"),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 30, left: 20, right: 35, bottom: 35),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AddProduct()),
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: HexColor("416DDE"),
                    child: const FaIcon(FontAwesomeIcons.plus,
                        color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  const Text("Add New Product",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black))
                ],
              ),
            ),
            const SizedBox(height: 20),
            StreamBuilder(
                stream: product(),
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Something went wrong");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: ((context, index) {
                            final DocumentSnapshot dataProduct =
                                snapshot.data!.docs[index];
                            String priceString =
                                dataProduct['productPrice'].toString();
                            String combineString = 'Rp' + priceString + '/day';
                            return Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                  decoration:
                                      BoxDecoration(color: HexColor("F5F5F5")),
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          top: 15,
                                          bottom: 15,
                                          right: 10),
                                      child: Row(
                                        children: [
                                          Image.network(
                                              dataProduct['productImage'],
                                              width: 100,
                                              height: 100),
                                          const SizedBox(width: 10),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(dataProduct['productName'],
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                              const SizedBox(height: 10),
                                              Text(combineString,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          )),
                                          const SizedBox(width: 20),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                width: 80,
                                                height: 30,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EditProduct(
                                                                    dataProduct[
                                                                        'id'])));
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              HexColor(
                                                                  "4164DE")),
                                                  child: const Text("Edit",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              SizedBox(
                                                width: 80,
                                                height: 30,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    showDeleteButton(
                                                        context, dataProduct);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              HexColor(
                                                                  "4164DE")),
                                                  child: const Text("Delete",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ))),
                            );
                          })));
                }))
          ]),
        ));
  }

  showDeleteButton(BuildContext context, DocumentSnapshot deleteObject) {
    Widget confirmButton = SizedBox(
      width: 280,
      height: 40,
      child: ElevatedButton(
        onPressed: () {
          final product = FirebaseFirestore.instance
              .collection('product')
              .doc(deleteObject['id']);

          product.delete();

          Navigator.of(context).pop();
        },
        style: ElevatedButton.styleFrom(backgroundColor: HexColor("4164DE")),
        child: const Text("Confirm",
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
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
      contentPadding:
          const EdgeInsets.only(left: 22, right: 22, top: 12, bottom: 12),
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
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: HexColor("979797")),
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
}
