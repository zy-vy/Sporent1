import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';

import '../component/item_title.dart';
import '../component/product_gridview.dart';

class RenterDetail extends StatelessWidget {
  const RenterDetail(this.idOwner, {super.key});

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
          child: const Text("Renter Detail"),
        ),
        backgroundColor: HexColor("4164DE"),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: _size.width / 20, vertical: _size.height / 30),
          child: StreamBuilder(
            stream: firestore.collection("user").doc(idOwner).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                var id = snapshot.data!.id;
                var name = snapshot.data!.get("name");
                var multiplicity = snapshot.data!.get("municipality");
                var description = snapshot.data!.get("description");
                var image = snapshot.data!.get("image");

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: _size.height / 13,
                          width: _size.width / 6,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(image), fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(100)),
                        ),
                        SizedBox(width: _size.width / 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(multiplicity,
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
                        text: description,
                        fontSize: 14,
                        fontweight: FontWeight.normal,
                        maxLines: 5),
                    SizedBox(height: _size.height / 55),
                    StreamBuilder(
                      stream: firestore.collection("product").where("owner",
                          isEqualTo: firestore.collection("user").doc(id)).snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      List<QueryDocumentSnapshot<Map<String, dynamic>>>?
                          listDocs = snapshot.data?.docs;
                      int? productCount = listDocs?.length;
                      return ProductGridview(productCount: productCount, listDocs: listDocs);
                    }
                      },
                    )
                  ],
                );
              }
            },
          )),
    );
  }
}
