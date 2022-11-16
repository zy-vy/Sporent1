import 'package:flutter/material.dart';
import 'package:sporent/component/category_list.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(_size.width/25, _size.height/20, _size.width/25, 0),
          child: CategoryList()),
    );
  }
}
