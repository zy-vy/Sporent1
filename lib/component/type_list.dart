import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TypeList extends StatelessWidget {
  const TypeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    CollectionReference types =
        FirebaseFirestore.instance.collection('subcategory');
    return Container(
      margin: EdgeInsets.symmetric(vertical: _size.height / 100),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: StreamBuilder(
        stream: types.snapshots(),
        builder: (context, snapshot) {


          return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), itemBuilder: (context, index) {
            return Center();
          },);
        },
      ),
    );
  }
}
