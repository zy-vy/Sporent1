import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/product-card-renter.dart';
import 'package:sporent/screens/add-product-renter.dart';

class ManageProduct extends StatefulWidget {
  const ManageProduct({super.key});

  @override
  State<ManageProduct> createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  Stream<QuerySnapshot> product() =>
      FirebaseFirestore.instance.collection("product-renter").snapshots();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
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
                  MaterialPageRoute(builder: (context) => const AddProduct()),
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
                stream: product(),
                builder: ((context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text("There is no data"),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: ((context, index) {
                              final DocumentSnapshot dataProduct =
                                  snapshot.data!.docs[index];
                              String priceString =
                                  dataProduct['price'].toString();
                              String combineString = 'Rp$priceString/day';
                              return ProductCardRenter(
                                  dataProduct, combineString);
                            })));
                  }
                }))
          ]),
        ));
  }
}
