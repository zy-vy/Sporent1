import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sporent/component/product_gridview.dart';

class ProductRecommendation extends StatefulWidget {
  const ProductRecommendation({Key? key}) : super(key: key);

  @override
  State<ProductRecommendation> createState() => _ProductRecommendationState();
}

class _ProductRecommendationState extends State<ProductRecommendation> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Container(
          padding: EdgeInsets.only(
              left: _size.width / 50),
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
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      List<QueryDocumentSnapshot<Map<String, dynamic>>>?
                          listDocs = snapshot.data?.docs;
                      int? productCount = listDocs?.length;
                      return ProductGridview(productCount: productCount, listDocs: listDocs);
                    }

                  case ConnectionState.done:
                    return const Text('Streaming is done');
                }
              })
    );
  }
}
