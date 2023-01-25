import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/model/user.dart';

import '../component/image_full_screen.dart';
import '../component/item_title.dart';
import '../component/product_gridview.dart';

class OwnerDetail extends StatelessWidget {
  const OwnerDetail(this.idOwner, {super.key});

  final String idOwner;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Owner Detail"),
          ),
          backgroundColor: HexColor("4164DE"),
        ),
        body: ListView(children: [
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: _size.width / 20, vertical: _size.height / 30),
              child: StreamBuilder(
                stream: firestore.collection("user").doc(idOwner).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    UserLocal user = UserLocal.fromDocument(
                        snapshot.data!.id, snapshot.data!.data()!);

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              child: ClipOval(
                                  child: CachedNetworkImage(
                                      height: _size.height / 13,
                                      width: _size.width / 6,
                                      imageUrl: user.owner_image!,
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator())),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => FullScreen("url",
                                        url: user.owner_image),
                                  ),
                                );
                              },
                            ),
                            SizedBox(width: _size.width / 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.owner_name!,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(user.owner_municipality!,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: HexColor("A5A2A2")))
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: _size.height / 35),
                        ItemTitle(
                            text: user.owner_description!,
                            fontSize: 14,
                            fontweight: FontWeight.normal,
                            maxLines: 5),
                        SizedBox(height: _size.height / 55),
                        StreamBuilder(
                          stream: firestore
                              .collection("product")
                              .where("owner",
                                  isEqualTo:
                                      firestore.collection("user").doc(user.id))
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              List<QueryDocumentSnapshot<Map<String, dynamic>>>?
                                  listDocs = snapshot.data?.docs;
                              int? productCount = listDocs?.length;
                              return ProductGridview(
                                  productCount: productCount,
                                  listDocs: listDocs);
                            }
                          },
                        )
                      ],
                    );
                  }
                },
              )),
        ]));
  }
}
