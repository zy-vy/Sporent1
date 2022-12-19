import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sporent/component/product_gridview.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var firestore = FirebaseFirestore.instance;
    var _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
      margin: EdgeInsets.symmetric(vertical: _size.height / 100),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: StreamBuilder(
          stream: firestore.collection('product').snapshots(),
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
                  List<QueryDocumentSnapshot<Map<String, dynamic>>>? listDocs =
                      snapshot.data?.docs;
                  inspect(listDocs);
                  int? productCount = listDocs?.length;
                  return ProductGridview(productCount: productCount, listDocs: listDocs);
                }

              case ConnectionState.done:
                return const Text('Streaming is done');
            }
          }),
    )
    );
  }
}
