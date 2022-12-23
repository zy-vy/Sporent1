import 'package:flutter/material.dart';
import 'package:sporent/component/type_list.dart';
import 'package:sporent/model/category.dart';

class TypeScreen extends StatelessWidget {
  const TypeScreen({Key? key, required Category category}) : _category = category, super(key: key);

  final Category _category;
  
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          margin: EdgeInsets.fromLTRB(_size.width/25, _size.height/20, _size.width/25, 0),
          child: TypeList(category: _category,)),
    );
  }
}
