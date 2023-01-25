import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sporent/component/popular_category.dart';
import 'package:sporent/component/product_card.dart';
import 'package:sporent/component/product_recommend.dart';
import 'package:sporent/component/search_bar_product.dart';
import 'package:sporent/screens/all_category.dart';
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
        padding: EdgeInsets.fromLTRB(
            _size.width / 25, _size.height / 20, _size.width / 25, _size.height / 20),
        child: Column(
          children: [
            HeadingCategory(size: _size),
            const PopularCategory(),
            HeadingRecommend(size: _size),
            const ProductRecommendation(),
          ],
        ),
      ),
    ));
  }
}

class HeadingRecommend extends StatelessWidget {
  const HeadingRecommend({
    Key? key,
    required Size size,
  })  : _size = size,
        super(key: key);

  final Size _size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: _size.width / 50, vertical: _size.height / 75),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Product Recommendation",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductListScreen(),
                    ));
              },
              child: const Text(
                "See all",
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
  })  : _size = size,
        super(key: key);

  final Size _size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: _size.width / 50, vertical: _size.height / 75),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Popular Categories",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AllCategory()));
            },
            child: const Text(
              "See all",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}
