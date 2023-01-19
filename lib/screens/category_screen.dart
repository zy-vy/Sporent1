import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/category_list.dart';

import '../component/product_gridview.dart';
import '../model/category.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen(this.category, {Key? key}) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: Text(category.olahraga.toString()),
          ),
          backgroundColor: HexColor("4164DE"),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
              horizontal: _size.width / 30, vertical: _size.height / 60),
          child: StreamBuilder(
              stream: firestore
                  .collection('product')
                  .where("category",
                      isEqualTo:
                          firestore.collection("category").doc(category.id))
                  .snapshots(),
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
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text("This Category Don't Have Product"),
                      );
                    } else {
                      List<QueryDocumentSnapshot<Map<String, dynamic>>>?
                          listDocs = snapshot.data?.docs;
                      int? productCount = listDocs?.length;
                      return ProductGridview(
                          productCount: productCount, listDocs: listDocs);
                    }

                  case ConnectionState.done:
                    return const Text('Streaming is done');
                }
              }),
        ));
  }
}
