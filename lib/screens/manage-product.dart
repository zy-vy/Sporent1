import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/product_card_renter.dart';
import 'package:sporent/screens/add_product.dart';
import 'package:sporent/screens/profile_owner.dart';

import '../model/product.dart';

class ManageProduct extends StatefulWidget {
  const ManageProduct(this.id, {super.key});

  final String? id;

  @override
  State<ManageProduct> createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
            icon: const FaIcon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => OwnerProfile(widget.id)));
            },
          ),
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Manage Product"),
          ),
          backgroundColor: HexColor("4164DE"),
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: _size.height / 30, horizontal: _size.width / 18),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => AddProduct(widget.id)),
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: HexColor("416DDE"),
                    child: const FaIcon(FontAwesomeIcons.plus,
                        color: Colors.white),
                  ),
                  SizedBox(width: _size.width / 50),
                  const Text("Add New Product",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black))
                ],
              ),
            ),
            SizedBox(height: _size.height / 40),
            StreamBuilder(
                stream: firestore
                    .collection("product")
                    .where("owner",
                        isEqualTo: firestore.collection("user").doc(widget.id))
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text("There is no data"),
                    );
                  } else {
                    return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: ((context, index) {
                              Product product = Product.fromDocument(
                                  snapshot.data!.docs[index].id,
                                  snapshot.data!.docs[index].data());
                              return ProductCardRenter(product);
                            })));
                  }
                }))
          ]),
        ));
  }
}
