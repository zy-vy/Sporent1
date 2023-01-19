import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/review_component.dart';

import '../component/item_title.dart';
import '../component/product_gridview.dart';
import '../model/review.dart';

class UserReview extends StatelessWidget {
  const UserReview(this.idProduct, {super.key});

  final String? idProduct;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
          child: const Text("User Review"),
        ),
        backgroundColor: HexColor("4164DE"),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: _size.width / 18, vertical: _size.height / 30),
          child: StreamBuilder(
            stream: firestore
                .collection("review")
                .where('product',
                    isEqualTo: firestore.collection("product").doc(idProduct))
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text("This Product Don't Have Review"),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Review review = Review.fromDocument(
                          snapshot.data!.docs[index].id,
                          snapshot.data!.docs[index].data());

                      var length = snapshot.data!.docs.length;

                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  margin:
                                      EdgeInsets.only(right: _size.width / 80),
                                  child: FaIcon(FontAwesomeIcons.solidStar,
                                      size: 40, color: HexColor("ED8A19"))),
                              const Text("4.8",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25)),
                              SizedBox(width: _size.width / 50),
                              Text("$length Rating ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                      color: HexColor("8D8888")))
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: _size.height / 50),
                            child: ReviewComponent(review, true),
                          )
                        ],
                      );
                    });
              }
            },
          )),
    );
  }
}
