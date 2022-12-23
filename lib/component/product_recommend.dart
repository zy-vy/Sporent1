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
    // TODO: implement initState
    // getProduct();
    // testList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: _size.height / 100),
      height: _size.height * 0.49,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
          // decoration: BoxDecoration(border: Border.all()),
          padding: EdgeInsets.symmetric(
              horizontal: _size.width / 30, vertical: _size.width / 30),
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
              })

          // StreamBuilder(
          //     stream: firestore.collection('product').snapshots(),
          //     builder: (context, snapshot) {
          //       if (!snapshot.hasData) {
          //         return const Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       } else {
          //         return GridView(
          //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //                 crossAxisCount: 2),
          //             scrollDirection: Axis.vertical,
          //             controller: ScrollController(),
          //             children: snapshot.data!.docs.map((e) {
          //               Map<String, dynamic> list = e.data();
          //               return Text(list['name'] ?? "");
          //             }).toList());
          //       }
          //     }),
          ),
    );
  }

  void testList() {
    firestore.collection('product').snapshots().forEach((element) {
      log("=== elements: ${element.toString()}");
      inspect(element);
      for (var element1 in element.docs) {
        log("=== doc element: ${element1.toString()}");
        inspect(element1);
      }
    });
  }

  Future<void> getProduct() async {
    var result = firestore.collection('product').snapshots();

    inspect(result);
  }
}


