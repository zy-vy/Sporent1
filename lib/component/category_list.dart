import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sporent/model/category.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    // test();
    super.initState();
  }

  void test() {
    firestore.collection('category').snapshots().forEach((element) {
      log("=== elements: ${element.toString()}");
      inspect(element);
      element.docs.forEach((element1) {
        log("=== doc element: ${element1.toString()}");
        inspect(element1);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: _size.height / 100),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: StreamBuilder(
        stream: firestore.collection('category').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else {
            var itemCount = snapshot.data!.docs.length;
            return GridView.builder(
              itemCount: itemCount,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,

                childAspectRatio: 1.0,
              ),
              itemBuilder: (context, index) {

                Category category = Category.fromDocument( snapshot.data!.docs[index].data());
                return
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ImageIcon(AssetImage("assets/icons/${category.olahraga}.png")),
                        Text(category.olahraga)
                      ],

                    ),
                  );


              },

            );
          }

        },
      ),
    );
  }
}
