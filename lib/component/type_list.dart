import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sporent/model/category.dart';
import 'package:sporent/model/subcategory.dart';

class TypeList extends StatelessWidget {
  const TypeList({Key? key, required Category category})
      : _category = category,
        super(key: key);

  final Category _category;

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;

    Fluttertoast.showToast(msg: _category.id??"");
    Size _size = MediaQuery.of(context).size;
    CollectionReference types =
        FirebaseFirestore.instance.collection('subcategory');

    var catRef = firestore.collection('category').doc(_category.id);
    inspect(catRef);
    return Container(
      margin: EdgeInsets.symmetric(vertical: _size.height / 100),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: StreamBuilder(
        stream: firestore
            .collection('subcategory')
            .where("category", isEqualTo: catRef)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var a = snapshot.data?.docs;
          List<Subcategory> listType = Subcategory.fromSnapshot(a!);
          inspect(listType);
          return GridView.builder(
            itemCount: listType.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {

                },
                child: Center(
                  child: Text(listType[index].type),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
