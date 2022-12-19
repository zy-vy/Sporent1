import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/product-card-renter.dart';
import 'package:sporent/screens/add-product-renter.dart';

import '../component/firebase_image.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Stream<QuerySnapshot> product() =>
      FirebaseFirestore.instance.collection("product-renter").snapshots();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        resizeToAvoidBottomInset: false,
        body: StreamBuilder(
            stream: product(),
            builder: ((context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: ((context, index) {
                          final DocumentSnapshot dataProduct =
                              snapshot.data!.docs[index];
                          return SizedBox(
                              width: _size.width,
                              height: _size.height / 8,
                              child: FirebaseImage(
                                  filePath:
                                      "product-images/${dataProduct['image']}"));
                        })));
              }
            })));
  }
}
