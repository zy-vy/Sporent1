import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/product_gridview.dart';

class ResultSearchProduct extends StatefulWidget {
  const ResultSearchProduct(this.search_keyword, this.isLogin, {super.key});

  final String search_keyword;
  final bool isLogin;

  @override
  State<ResultSearchProduct> createState() => _ResultSearchProductState();
}

class _ResultSearchProductState extends State<ResultSearchProduct> {
  List dataProduct = [];

  void fetchAllProduct(List dataProduct) async {
    var snapshot = FirebaseFirestore.instance.collection("product").get();
    snapshot.then((value) => value.docs.forEach((element) {
          if(dataProduct.length>9) return;
          String name = element.get("name");
          if (name
              .toLowerCase()
              .contains(widget.search_keyword.toLowerCase())) {
            dataProduct.add(name);
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    var firestore = FirebaseFirestore.instance;
    var _size = MediaQuery.of(context).size;
    fetchAllProduct(dataProduct);

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Result Search Product"),
          ),
          backgroundColor: HexColor("4164DE"),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
              horizontal: _size.width / 30, vertical: _size.height / 60),
          child: StreamBuilder(
              stream: firestore
                  .collection('product')
                  .where('name', whereIn: dataProduct.isNotEmpty? dataProduct : ["biar gk error ygy"])
                  .snapshots().take(10),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error in receiving data: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<QueryDocumentSnapshot<Map<String, dynamic>>>? listDocs =
                      snapshot.data?.docs;
                  int? productCount = listDocs?.length;
                  return ProductGridview(
                    productCount: productCount,
                    listDocs: listDocs,
                    isLogin: widget.isLogin,
                  );
                }
              }),
        ));
  }
}
