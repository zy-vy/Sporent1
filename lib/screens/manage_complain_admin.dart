import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/firebase_image.dart';
import 'package:sporent/model/complain.dart';
import 'package:sporent/model/complain_detail.dart';
import 'package:sporent/model/transaction.dart';
import 'package:sporent/screens/admin_screen.dart';
import 'package:sporent/screens/complain_detail.dart';

import '../model/product.dart';

class ManageComplain extends StatelessWidget {
  const ManageComplain({super.key});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const FaIcon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AdminProfile()));
            },
          ),
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Manage Complain"),
          ),
          backgroundColor: HexColor("4164DE"),
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
            padding: EdgeInsets.symmetric(
                vertical: _size.height / 30, horizontal: _size.width / 18),
            child: StreamBuilder(
              stream: firestore.collection("complain").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      bool haveLine = false;
                      Complain complain = Complain.fromDocument(
                          snapshot.data!.docs[index].id,
                          snapshot.data!.docs[index].data(),
                          false);
                      if (index != 0) {
                        haveLine = true;
                      }
                      return Column(
                        children: [
                          haveLine == true
                              ? Divider(color: HexColor("E0E0E0"), thickness: 2)
                              : const SizedBox(),
                          SizedBox(height: _size.height / 30),
                          StreamBuilder(
                            stream: firestore
                                .collection("transaction")
                                .doc(complain.transaction!.id)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else {
                                TransactionModel transaction =
                                    TransactionModel.fromDocument(
                                        snapshot.data!.id,
                                        snapshot.data!.data()!);

                                return StreamBuilder(
                                    stream: firestore
                                        .collection("product")
                                        .doc(transaction.product!.id)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      } else {
                                        Product product = Product.fromDocument(
                                            snapshot.data!.id,
                                            snapshot.data!.data()!);

                                        return TextButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailComplain(
                                                            complain.id!,
                                                            product.name!,
                                                            product.img!,
                                                            transaction.total!,
                                                            "admin",
                                                            idUser: transaction
                                                                .user!.id,
                                                            idOwner: transaction
                                                                .owner!.id,
                                                            idTransaction:
                                                                transaction.id,
                                                          )));
                                            },
                                            child: Row(
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl:
                                                      snapshot.data!.get("img"),
                                                  width: _size.width / 3,
                                                  height: _size.height / 5.8,
                                                ),
                                                SizedBox(
                                                    width: _size.width / 30),
                                                Flexible(
                                                    child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        snapshot.data!
                                                            .get("name"),
                                                        style: const TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black)),
                                                    SizedBox(
                                                        height:
                                                            _size.height / 40),
                                                    Text(
                                                        "Status: ${complain.status}",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: HexColor(
                                                                "416DDE"))),
                                                  ],
                                                ))
                                              ],
                                            ));
                                      }
                                    });
                              }
                            },
                          ),
                          SizedBox(height: _size.height / 30),
                        ],
                      );
                    },
                  );
                }
              },
            )));
  }
}
