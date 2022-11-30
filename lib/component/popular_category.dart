import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sporent/model/category.dart';
import 'package:sporent/repository/category_repository.dart';
import 'package:sporent/screens/type_screen.dart';

class PopularCategory extends StatefulWidget {
  const PopularCategory({Key? key}) : super(key: key);

  @override
  State<PopularCategory> createState() => _PopularCategoryState();
}

class _PopularCategoryState extends State<PopularCategory> {
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    CategoryRepository categoryRepository = CategoryRepository();
    return Container(
      margin: EdgeInsets.symmetric(vertical: _size.height/100),
      padding: const EdgeInsets.all(10.0),
      height: _size.height/8,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: StreamBuilder(
        // stream: firestore.collection('category').snapshots(),
        stream: categoryRepository.getCategoryList(),
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // var docs = snapshot.data!.docs;
          // List<Category> listCategory = Category.fromSnapshot(docs);
          List<Category> listCategory = snapshot.data!;
          return ListView.builder(
            itemCount: 6,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
            Category category = listCategory[index];
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TypeScreen(category: category),));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: ImageIcon(
                               AssetImage("assets/icons/${category.olahraga}.png"),

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child:  Text("${category.olahraga}")),
                          )
                        ],
                      ),
            );
          },
          );
        },
      ),
    );
  }
}

