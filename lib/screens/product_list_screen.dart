import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/product_gridview.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({Key? key, required this.isLogin}) : super(key: key);

  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    var firestore = FirebaseFirestore.instance;
    var _size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Product Recommendation"),
          ),
          backgroundColor: HexColor("4164DE"),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
              horizontal: _size.width / 30, vertical: _size.height / 60),
          child: StreamBuilder(
              stream: firestore.collection('product').snapshots().take(10),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error in receiving data: ${snapshot.error}');
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Text('Not connected to the Stream or null');

                  case ConnectionState.waiting:
                    return const Text('Awaiting for interaction');

                  case ConnectionState.active:
                    log("Stream has started but not finished");
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      List<QueryDocumentSnapshot<Map<String, dynamic>>>?
                          listDocs = snapshot.data?.docs;
                      inspect(listDocs);
                      int? productCount = listDocs?.length;
                      return ProductGridview(
                          productCount: productCount, listDocs: listDocs, isLogin: isLogin,);
                    }

                  case ConnectionState.done:
                    return const Text('Streaming is done');
                }
              }),
        ));
  }
}
