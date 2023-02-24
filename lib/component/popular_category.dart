import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/model/category.dart';
import 'package:sporent/repository/category_repository.dart';
import 'package:sporent/screens/category_screen.dart';
import 'package:sporent/screens/all_product_category.dart';

class PopularCategory extends StatefulWidget {
  const PopularCategory(this.isLogin, {Key? key}) : super(key: key);

  final bool isLogin;

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
      margin: EdgeInsets.symmetric(vertical: _size.height / 100),
      padding: EdgeInsets.only(left: _size.width / 50),
      height: _size.height / 8,
      width: double.infinity,
      child: StreamBuilder(
        // stream: firestore.collection('category').snapshots(),
        stream: categoryRepository.getCategoryList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Category> listCategory = snapshot.data!;
          List<IconData> icon = [
            FontAwesomeIcons.basketball,
            FontAwesomeIcons.volleyball,
            FontAwesomeIcons.personBiking,
            FontAwesomeIcons.dumbbell
          ];
          return ListView.builder(
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              Category category = listCategory[index];
              return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryScreen(category, widget.isLogin),
                        ));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: _size.width / 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            width: _size.height / 15,
                            height: _size.height / 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: HexColor("828282")),
                              color: Colors.white,
                            ),
                            child: Center(
                                child: FaIcon(
                              icon[index],
                              color: HexColor("646262"),
                            ))),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Center(child: Text("${category.olahraga}")),
                        )
                      ],
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}
