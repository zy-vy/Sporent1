import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sporent/component/product_gridview.dart';

class ProductRecommendation extends StatefulWidget {
  const ProductRecommendation({Key? key, required this.isLogin}) : super(key: key);

  final bool isLogin;

  @override
  State<ProductRecommendation> createState() => _ProductRecommendationState();
}

class _ProductRecommendationState extends State<ProductRecommendation> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.only(left: _size.width / 50),
        child: StreamBuilder(
            stream: firestore.collection('product').snapshots(),
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
                    productCount: productCount, listDocs: listDocs, isLogin: widget.isLogin,);
              }
            }));
  }
}
