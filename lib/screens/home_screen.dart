import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sporent/component/popular_category.dart';
import 'package:sporent/component/product_card.dart';
import 'package:sporent/component/product_recommend.dart';
import 'package:sporent/component/search_bar_product.dart';
import 'package:sporent/screens/category_screen.dart';
import 'package:sporent/screens/product_list_screen.dart';

import '../model/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(

            padding: EdgeInsets.fromLTRB(_size.width/25, _size.height/20, _size.width/25,  0),
            child: Column(
              children: [
                const SearchBarProduct(),
                HeadingCategory(size: _size),
                const PopularCategory(),
                HeadingRecommend(size: _size),
                const ProductRecommendation(),


              ],
            ),
          ),
        ));
  }

  // Stream<List<Product>> getProductList() {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   CollectionReference products = firestore.collection('product');
  //
  //   Stream<List<Product>> list = products.snapshots().map(
  //           (snapshot) =>
  //           snapshot.docs.map(
  //                   (doc) =>
  //                   Product.fromDocument(doc.id,doc.data() as Map<String, dynamic>))
  //               .toList());
  //   log("====data $list");
  //   return list;
  //
  //   // return FirebaseFirestore.instance.collection('product').snapshots().map(
  //   //     (snapshot) =>
  //   //         snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList());
  // }
}

class HeadingRecommend extends StatelessWidget {
  const HeadingRecommend({
    Key? key,
    required Size size,
  }) : _size = size, super(key: key);

  final Size _size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: _size.width / 30, vertical: _size.height / 75),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Today's Recommendation",
              style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductListScreen(),));
              },
              child: const Text(
                "see all",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          )
        ],
      ),
    );
  }
}


class HeadingCategory extends StatelessWidget {
  const HeadingCategory({
    Key? key,
    required Size size,
  }) : _size = size, super(key: key);

  final Size _size;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: _size.width / 30, vertical: _size.height / 75),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  [
          const Text("Popular Categories",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20)),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:(context) => const CategoryScreen(), ));
            },

            child: const Text(
              "see all",
              style: TextStyle(color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
