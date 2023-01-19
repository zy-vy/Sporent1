import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/model/category.dart';
import 'package:sporent/repository/category_repository.dart';
import 'package:sporent/screens/category_screen.dart';

class AllCategory extends StatefulWidget {
  const AllCategory({Key? key}) : super(key: key);

  @override
  State<AllCategory> createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    CategoryRepository categoryRepository = CategoryRepository();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: HexColor("4164DE"),
        title: const Text("Category"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: _size.height/30),
        child: StreamBuilder(
          stream: categoryRepository.getCategoryList(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<Category> listCategory = snapshot.data!;
            List<IconData> icon = [FontAwesomeIcons.basketball, FontAwesomeIcons.volleyball, FontAwesomeIcons.personBiking, FontAwesomeIcons.dumbbell, FontAwesomeIcons.futbol, Icons.sports_tennis_outlined];
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4
              ),
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                Category category = listCategory[index];
                return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryScreen(category),
                          ));
                    },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: _size.width/7,
                              height: _size.height/15,
                              decoration:
                                  BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: HexColor("828282")),
                                    color: Colors.white),
                              child:  Center(child: FaIcon(icon[index], color: HexColor("646262"),))
                              ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: _size.height/85),
                              child: Center(child: Text("${category.olahraga}")),
                            ),
                          ],
                      ));
              },
            );
          },
        ),
      ),
    );
  }
}
