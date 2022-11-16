import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/product.dart';

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
      height: _size.height * 0.6,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
          decoration: BoxDecoration(border: Border.all()),
          padding: EdgeInsets.symmetric(
              horizontal: _size.width / 30, vertical: _size.height / 75),
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
                      return GridView.builder(
                          physics: const ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          controller: ScrollController(),
                          shrinkWrap: true,
                          itemCount: productCount,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            // Product p = Product.fromJson(listDocs![index].data());
                            return Center(
                              child: Text(
                                  "name: ${listDocs![index].data().toString()}"),
                            );
                          });
                    }

                  case ConnectionState.done:
                    return new Text('Streaming is done');
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
      element.docs.forEach((element1) {
        log("=== doc element: ${element1.toString()}");
        inspect(element1);
      });
    });
  }

  Future<void> getProduct() async {
    var result = firestore.collection('product').snapshots();

    inspect(result);
  }
}
