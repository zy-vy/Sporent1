import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sporent/component/popular_category.dart';
import 'package:sporent/component/product_card.dart';
import 'package:sporent/component/product_recommend.dart';
import 'package:sporent/component/search_bar_product.dart';
import 'package:sporent/screens/all_category.dart';
import 'package:sporent/screens/category_screen.dart';
import 'package:sporent/screens/product_list_screen.dart';

import '../component/loading.dart';
import '../model/product.dart';
import '../model/user.dart';
import '../repository/user_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final _userRepository = UserRepository();
  UserLocal? user;
  bool isLoggedIn = false;
  bool isLoading = true;
  int counter = 0;

  Future fetchUser() async {
    await Future.delayed(const Duration(seconds: 1));
    if (FirebaseAuth.instance.currentUser != null) {
      user = await _userRepository
          .getUserById(FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        isLoggedIn = true;
        isLoading = false;
        counter = 1;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    counter == 0 ? fetchUser() : counter;

    return isLoading
        ? const Loading()
        : Scaffold(
            body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(_size.width / 25, _size.height / 20,
                  _size.width / 25, _size.height / 20),
              child: Column(
                children: [
                  HeadingCategory(size: _size, isLogin: isLoggedIn),
                  PopularCategory(isLoggedIn),
                  HeadingRecommend(size: _size, isLogin: isLoggedIn),
                  ProductRecommendation(isLogin: isLoggedIn),
                ],
              ),
            ),
          ));
  }
}

class HeadingRecommend extends StatelessWidget {
  const HeadingRecommend({Key? key, required Size size, required this.isLogin})
      : _size = size,
        super(key: key);

  final Size _size;
  final bool isLogin;

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
                      builder: (context) => ProductListScreen(isLogin: isLogin),
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
    required this.isLogin, 
  })  : _size = size,
        super(key: key);

  final Size _size;
  final bool isLogin;

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
                  MaterialPageRoute(builder: (context) => AllCategory(isLogin)));
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
