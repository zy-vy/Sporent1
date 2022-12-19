import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sporent/component/firebase_image.dart';
import 'package:sporent/component/item_price.dart';
import 'package:sporent/component/item_title.dart';
import 'package:sporent/component/owner_thumbnail.dart';
import 'package:sporent/controller/cart_controller.dart';
import 'package:sporent/model/product.dart';

import '../model/category.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({Key? key, required Product product})
      : _product = product,
        super(key: key);

  final Product _product;

  final productPath = "product-images/";

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    inspect(_product);
    DateTime? startDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    var dateFormat = DateFormat('dd-MM-yyyy');
    DateTime? endDate;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: HexColor("4164DE"), size: 30),
      ),
      extendBodyBehindAppBar: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
          width: size.width,
          padding: EdgeInsets.symmetric(
              horizontal: size.width / 15, vertical: size.width / 25),
          child: FloatingActionButton(
              onPressed: () {
                CartController controller = CartController();
                showModalBottomSheet(
                    context: context,
                    builder: (context) => StatefulBuilder(builder:
                            (BuildContext context,
                                StateSetter
                                    setBottomState /*You can rename this!*/) {
                          return Container(
                            height: size.height / 3,
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width / 15,
                                vertical: size.width / 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: const [
                                    Expanded(
                                        child: Text("start date: ",
                                            textAlign: TextAlign.center)),
                                    Expanded(
                                        child: Text("end date: ",
                                            textAlign: TextAlign.center)),
                                  ],
                                ),
                                SizedBox(
                                  height: size.width / 25,
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                          child: Text(
                                              startDate != null
                                                  ? dateFormat
                                                      .format(startDate!)
                                                  : "not selected yet",
                                              textAlign: TextAlign.center)),
                                      Expanded(
                                          child: Text(
                                              endDate != null
                                                  ? dateFormat.format(endDate!)
                                                  : "not selected yet",
                                              textAlign: TextAlign.center)),
                                    ]),
                                SizedBox(
                                  height: size.width / 25,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                        child: IconButton(
                                      icon: const Icon(
                                          Icons.calendar_month_rounded),
                                      onPressed: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: startDate!,
                                                firstDate: DateTime.now()
                                                    .subtract(const Duration(
                                                        days: 0)),
                                                lastDate: DateTime(2100))
                                            .then((value) {
                                          if (value != null) {
                                            if (endDate != null &&
                                                value.isAfter(endDate!)) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Error ! start date must be before end date (${dateFormat.format(endDate!)})");
                                            } else {
                                              startDate = value;
                                              setBottomState(() {});
                                            }
                                          }
                                        });
                                      },
                                    )),
                                    Expanded(
                                        child: IconButton(
                                      icon: const Icon(
                                          Icons.calendar_month_rounded),
                                      onPressed: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate:
                                                    endDate ?? startDate!,
                                                firstDate: startDate!,
                                                lastDate: DateTime(2100))
                                            .then((value) {
                                          if (value != null) {
                                            endDate = value;
                                            setBottomState(() {});
                                          }
                                        });
                                      },
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  height: size.width / 25,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        log("$startDate\n$endDate");
                                        if (startDate == null ||
                                            endDate == null) {
                                          Fluttertoast.showToast(
                                              msg: "Please select date");
                                        } else {
                                          final difference = daysBetween(
                                                  startDate!, endDate!) +
                                              1;
                                          log("--- diff $difference");
                                          await controller.addToCart(_product,
                                              startDate!, endDate!, difference);
                                        }
                                      },
                                      child: const Text("Add to Cart")),
                                )
                              ],
                            ),
                          );
                        }));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: HexColor("4164DE"),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(right: size.width / 85),
                      child: const FaIcon(FontAwesomeIcons.cartShopping,
                          size: 15)),
                  const Text("Add to Cart"),
                ],
              ))),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width,
              height: size.height / 2,
              child: FirebaseImage(filePath: "$productPath${_product.id}.jpg"),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width / 20, vertical: size.width / 35),
              child: ItemTitle(
                  text: _product.name ?? "",
                  fontSize: 23,
                  fontweight: FontWeight.w500,
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width / 20),
              child: ItemPrice(
                price: _product.rentPrice,
                fontSize: 30,
                trail: true,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width / 20, vertical: size.width / 35),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: size.width/20),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: size.width/80),
                          child: FaIcon(FontAwesomeIcons.solidStar, color: HexColor("ED8A19"))),
                        const Text("4.8", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15))
                      ],
                    ),
                  ),
                  Text("Telah dipinjam sebanyak 25", style: TextStyle(color: HexColor("585858"), fontWeight: FontWeight.w600, fontSize: 13))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width / 20, vertical: size.width / 35),
              child: ItemTitle(
                  text: _product.description ?? "",
                  fontSize: 16,
                  fontweight: FontWeight.normal,
                  maxLines: 5),
            ),
            StreamBuilder(
              stream: firestore.collection('category').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  DocumentReference categoryReference =
                      firestore.doc(_product.category.toString());
                  var currentCategory =
                      categoryReference.id.replaceAll(')', '');
                  for (int i = 0; i < snapshot.data!.docs.length; i++) {
                    Category category = Category.fromDocument(
                        snapshot.data!.docs[i].id,
                        snapshot.data!.docs[i].data());
                    if (category.id == currentCategory) {
                      currentCategory = category.olahraga.toString();
                    }
                  }
                  return Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width / 20, vertical: size.width / 35),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: size.width/50),
                          child: const Text("Kategori:",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.normal)),
                        ),
                        ItemTitle(text: currentCategory, fontSize: 15, fontweight: FontWeight.bold,),
                      ],
                    ),
                  );
                }
              },
            ),
            Divider(color: HexColor("E6E6E6"), thickness: 3),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width / 20, vertical: size.width / 35),
              // child: CircleAvatar(backgroundImage: ),
            ),
            SizedBox(
              height: size.height / 20,
            ),
          ],
        ),
      ),
    );
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
