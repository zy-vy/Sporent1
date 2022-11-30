import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sporent/component/product_card.dart';

import '../model/product.dart';

class ProductGridview extends StatelessWidget {
  const ProductGridview({
    Key? key,
    required this.productCount,
    required this.listDocs,
  }) : super(key: key);

  final int? productCount;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>>? listDocs;

  @override
  Widget build(BuildContext context) {
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
            crossAxisSpacing: 10,
            childAspectRatio: 0.6
        ),
        itemBuilder: (context, index) {
          // Product p = Product.fromJson(listDocs![index].data());

          Product product = Product.fromDocument(listDocs![index].id, listDocs![index].data());
          return Center(
            child:
            ProductCard(product: product),
          );
        });
  }
}