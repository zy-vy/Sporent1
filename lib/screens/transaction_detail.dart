import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sporent/screens/bottom_bar.dart';
import 'package:sporent/screens/complain_detail.dart';
import 'package:sporent/screens/complain_product.dart';
import 'package:sporent/screens/condition_check_before_user.dart';
import 'package:sporent/screens/return_product.dart';
import 'package:sporent/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../component/firebase_image.dart';
import '../component/image_full_screen.dart';
import '../component/transaction_card_detail.dart';
import '../component/field_row.dart';
import '../model/transaction.dart';
import 'give_review.dart';

class DetailTransaction extends StatefulWidget {
  const DetailTransaction(this.idTransaction, this.product_image,
      this.product_name, this.idProduct, this.idUser,
      {super.key});

  final String idTransaction;
  final String product_image;
  final String product_name;
  final String idProduct;
  final String idUser;

  @override
  State<DetailTransaction> createState() => _DetailTransaction();
}

class _DetailTransaction extends State<DetailTransaction> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool haveComplain = false;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    var dateFormat = DateFormat('d MMMM ' 'yyyy');
    var dateFormatTime = DateFormat('d MMMM ' 'yyyy ' 'HH:mm:ss');
    NumberFormat currencyFormatter =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const FaIcon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const BottomBarScreen(
                        indexPage: "1",
                      )));
            }
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (context) => const BottomBarScreen(indexPage: "3")));
            ),
        centerTitle: false,
        title: Transform(
          transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
          child: const Text("Detail Transaction"),
        ),
        backgroundColor: hexStringToColor("4164DE"),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: _size.height / 40,
            bottom: _size.height / 40,
            left: _size.width / 18,
            right: _size.width / 10),
        child: SingleChildScrollView(
          child: StreamBuilder(
              stream: firestore
                  .collection("transaction")
                  .doc(widget.idTransaction)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  TransactionModel transaction = TransactionModel.fromDocument(
                      snapshot.data!.id, snapshot.data!.data()!);
                  final Uri _url =
                      Uri.parse(transaction.tracking_code_owner ?? "");
                  if (snapshot.data!.data()!.containsKey("complain") == true) {
                    haveComplain = true;
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Status: ${transaction.status}",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                      SizedBox(height: _size.height / 70),
                      Divider(color: hexStringToColor("E0E0E0"), thickness: 2),
                      SizedBox(height: _size.height / 70),
                      const Text(
                        "Booking Period",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: _size.height / 40),
                      bookingPeriod(dateFormat.format(transaction.start_date!),
                          dateFormat.format(transaction.end_date!), _size),
                      SizedBox(height: _size.height / 70),
                      Divider(color: hexStringToColor("E0E0E0"), thickness: 2),
                      DetailTransactionCard(
                          18,
                          16,
                          15,
                          18,
                          "Total Payment",
                          widget.product_image,
                          widget.product_name,
                          transaction.total!),
                      SizedBox(height: _size.height / 70),
                      Divider(color: hexStringToColor("E0E0E0"), thickness: 2),
                      SizedBox(height: _size.height / 50),
                      const Text(
                        "Delivery Information",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: _size.height / 40),
                      FieldRow("Delivery Type", transaction.delivery_method!,
                          true, 15, FontWeight.normal, FontWeight.w500),
                      SizedBox(height: _size.height / 70),
                      FieldRow("Address", transaction.delivery_location!, true,
                          15, FontWeight.normal, FontWeight.w500),
                      SizedBox(height: _size.height / 40),
                      Divider(color: hexStringToColor("E0E0E0"), thickness: 2),
                      SizedBox(height: _size.height / 40),
                      const Text("Live Tracking Gojek",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: _size.height / 40),
                      transaction.tracking_code_owner == null
                          ? const Text("Owner has not input the live tracking")
                          : InkWell(
                              child: Text(transaction.tracking_code_owner ?? "",
                                  style: const TextStyle(
                                      color: Colors.blueAccent)),
                              onTap: () async => await launchUrl(_url),
                            ),
                      SizedBox(height: _size.height / 40),
                      Divider(color: hexStringToColor("E0E0E0"), thickness: 2),
                      SizedBox(height: _size.height / 40),
                      snapshot.data!
                                  .data()!
                                  .containsKey("image_before_owner") ==
                              true
                          ? snapshot.data!.get("image_before_owner") != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Condition Check (Owner)",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: _size.height / 30,
                                    ),
                                    Row(
                                      children: [
                                        snapshot.data!.data()!.containsKey(
                                                    "image_before_owner") ==
                                                true
                                            ? snapshot.data!.get(
                                                        "image_before_owner") !=
                                                    null
                                                ? Column(
                                                    children: [
                                                      Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: HexColor(
                                                                      "E0E0E0")),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          width:
                                                              _size.width / 5,
                                                          height:
                                                              _size.height / 10,
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.of(context).push(
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          FullScreen(
                                                                            "firebaseImage",
                                                                            firebaseImage:
                                                                                snapshot.data!.get("image_before_owner"),
                                                                            filePath:
                                                                                "condition-check",
                                                                          )));
                                                            },
                                                            child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                child: FittedBox(
                                                                    fit: BoxFit.fill,
                                                                    child: FirebaseImage(
                                                                      filePath:
                                                                          "condition-check/${snapshot.data!.get("image_before_owner")}",
                                                                    ))),
                                                          )),
                                                      SizedBox(
                                                          height: _size.height /
                                                              60),
                                                      const Text(
                                                          "Before Owner"),
                                                    ],
                                                  )
                                                : const SizedBox()
                                            : const SizedBox(),
                                        SizedBox(width: _size.width / 5),
                                        snapshot.data!.data()!.containsKey(
                                                    "image_after_owner") ==
                                                true
                                            ? snapshot.data!.get(
                                                        "image_after_owner") !=
                                                    null
                                                ? Column(
                                                    children: [
                                                      Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: HexColor(
                                                                      "E0E0E0")),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          width:
                                                              _size.width / 5,
                                                          height:
                                                              _size.height / 10,
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.of(context).push(
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          FullScreen(
                                                                            "firebaseImage",
                                                                            firebaseImage:
                                                                                snapshot.data!.get("image_after_owner"),
                                                                            filePath:
                                                                                "condition-check",
                                                                          )));
                                                            },
                                                            child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                child: FittedBox(
                                                                    fit: BoxFit.fill,
                                                                    child: FirebaseImage(
                                                                      filePath:
                                                                          "condition-check/${snapshot.data!.get("image_after_owner")}",
                                                                    ))),
                                                          )),
                                                      SizedBox(
                                                          height: _size.height /
                                                              60),
                                                      const Text("After Owner")
                                                    ],
                                                  )
                                                : const SizedBox()
                                            : const SizedBox(),
                                      ],
                                    ),
                                    SizedBox(height: _size.height / 50),
                                    Divider(
                                        color: HexColor("E0E0E0"),
                                        thickness: 2),
                                    SizedBox(height: _size.height / 70),
                                  ],
                                )
                              : const SizedBox()
                          : const SizedBox(),
                      const Text(
                        "Condition Check (User)",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: _size.height / 30,
                      ),
                      snapshot.data!.data()!.containsKey('image_before_user') !=
                              true
                          ? TextButton(
                              style: TextButton.styleFrom(
                                  side: BorderSide(
                                      width: 1, color: HexColor("888888"))),
                              onPressed: transaction.status == "WAITING" ||
                                      transaction.status == "CONFIRM" ||
                                      transaction.status == "ACCEPT" ||
                                      transaction.status == "DECLINE" ||
                                      transaction.status == "REJECT"
                                  ? null
                                  : () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) =>
                                              ConditionCheckBeforeUser(
                                                  transaction.id!,
                                                  transaction
                                                          .image_before_user ??
                                                      "",
                                                  transaction
                                                          .description_before_user ??
                                                      "")));
                                    },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: _size.height / 80,
                                    horizontal: _size.width / 70),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Pre-Condition",
                                          style: TextStyle(
                                              color:
                                                  transaction.status ==
                                                              "WAITING" ||
                                                          transaction.status ==
                                                              "ACCEPT" ||
                                                          transaction.status ==
                                                              "CONFIRM" ||
                                                          transaction.status ==
                                                              "DECLINE" ||
                                                          transaction.status ==
                                                              "REJECT"
                                                      ? Colors.grey
                                                      : Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        SizedBox(height: _size.height / 80),
                                        transaction.status == "DELIVER"
                                            ? const Text(
                                                "This check is ready",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13),
                                              )
                                            : const Text(
                                                "This check is not ready at this time",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 13),
                                              )
                                      ],
                                    )),
                                    FaIcon(FontAwesomeIcons.chevronRight,
                                        color:
                                            transaction.status == "WAITING" ||
                                                    transaction.status ==
                                                        "ACCEPT" ||
                                                    transaction.status ==
                                                        "CONFIRM" ||
                                                    transaction.status ==
                                                        "DECLINE" ||
                                                    transaction.status ==
                                                        "REJECT"
                                                ? Colors.grey
                                                : Colors.black,
                                        size: 20)
                                  ],
                                ),
                              ))
                          : const SizedBox(),
                      snapshot.data!.data()!.containsKey("image_before_user") ==
                              true
                          ? snapshot.data!.get("image_before_user") != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        snapshot.data!.data()!.containsKey(
                                                    "image_before_user") ==
                                                true
                                            ? snapshot.data!.get(
                                                        "image_before_user") !=
                                                    null
                                                ? Column(
                                                    children: [
                                                      Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: HexColor(
                                                                      "E0E0E0")),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          width:
                                                              _size.width / 5,
                                                          height:
                                                              _size.height / 10,
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.of(context).push(
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          FullScreen(
                                                                            "firebaseImage",
                                                                            firebaseImage:
                                                                                snapshot.data!.get("image_before_user"),
                                                                            filePath:
                                                                                "condition-check",
                                                                          )));
                                                            },
                                                            child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                child: FittedBox(
                                                                    fit: BoxFit.fill,
                                                                    child: FirebaseImage(
                                                                      filePath:
                                                                          "condition-check/${snapshot.data!.get("image_before_user")}",
                                                                    ))),
                                                          )),
                                                      SizedBox(
                                                          height: _size.height /
                                                              60),
                                                      const Text("Before User")
                                                    ],
                                                  )
                                                : const SizedBox()
                                            : const SizedBox(),
                                        SizedBox(width: _size.width / 5),
                                        snapshot.data!.data()!.containsKey(
                                                    "image_after_user") ==
                                                true
                                            ? snapshot.data!.get(
                                                        "image_after_user") !=
                                                    null
                                                ? Column(
                                                    children: [
                                                      Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: HexColor(
                                                                      "E0E0E0")),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          width:
                                                              _size.width / 5,
                                                          height:
                                                              _size.height / 10,
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.of(context).push(
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          FullScreen(
                                                                            "firebaseImage",
                                                                            firebaseImage:
                                                                                snapshot.data!.get("image_after_user"),
                                                                            filePath:
                                                                                "condition-check",
                                                                          )));
                                                            },
                                                            child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                child: FittedBox(
                                                                    fit: BoxFit.fill,
                                                                    child: FirebaseImage(
                                                                      filePath:
                                                                          "condition-check/${snapshot.data!.get("image_after_user")}",
                                                                    ))),
                                                          )),
                                                      SizedBox(
                                                          height: _size.height /
                                                              60),
                                                      const Text("After User")
                                                    ],
                                                  )
                                                : const SizedBox()
                                            : const SizedBox(),
                                      ],
                                    ),
                                    SizedBox(height: _size.height / 70),
                                  ],
                                )
                              : const SizedBox()
                          : const SizedBox(),
                      SizedBox(height: _size.height / 20),
                      transaction.image_after_user != null
                          ? const SizedBox()
                          : transaction.status == "RETURN"
                              ? const SizedBox()
                              : transaction.status == "DONE"
                                  ? const SizedBox()
                                  : SizedBox(
                                      width: _size.width,
                                      height: _size.height / 12,
                                      child: ElevatedButton(
                                        onPressed: transaction.status ==
                                                    "ACTIVE" &&
                                                dateFormat.format(transaction
                                                        .end_date!) ==
                                                    dateFormat
                                                        .format(DateTime.now())
                                            ? () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ReturnProduct(
                                                              idOwner:
                                                                  transaction
                                                                      .owner!
                                                                      .id,
                                                              transaction.id!,
                                                              "",
                                                              "",
                                                              idProduct: widget
                                                                  .idProduct,
                                                              idUser:
                                                                  widget.idUser,
                                                              product_image: widget
                                                                  .product_image,
                                                              product_name: widget
                                                                  .product_name,
                                                              total: transaction
                                                                  .total,
                                                            )));
                                              }
                                            : null,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: HexColor("4164DE"),
                                        ),
                                        child: const Text("Return Product",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                            textAlign: TextAlign.center),
                                      )),
                      SizedBox(height: _size.height / 40),
                      transaction.status == "RETURN" ||
                              transaction.status == "DONE"
                          ? const SizedBox()
                          : Center(
                              child: TextButton(
                                  onPressed: transaction.status == "ACTIVE" ||
                                          transaction.status == "COMPLAIN"
                                      ? () {
                                          if (snapshot.data!
                                              .data()!
                                              .containsKey("complain")) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailComplain(
                                                          transaction
                                                              .complain!.id,
                                                          widget.product_name,
                                                          widget.product_image,
                                                          transaction.total!,
                                                          idProduct:
                                                              widget.idProduct,
                                                          idTransaction:
                                                              transaction.id,
                                                          idUser: transaction
                                                              .user!.id,
                                                          "user")),
                                            );
                                          } else {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ComplainProduct(
                                                          transaction.owner!.id,
                                                          widget
                                                              .idTransaction)),
                                            );
                                          }
                                        }
                                      : null,
                                  child: Text(
                                    haveComplain
                                        ? "Complain Detail"
                                        : "Complain Product",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: transaction.status == "ACTIVE" ||
                                                transaction.status == "COMPLAIN"
                                            ? HexColor("4164DE")
                                            : Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}

Row bookingPeriod(String startDate, String endDate, Size _size) => Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              startDate,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        SizedBox(width: _size.width / 10),
        const FaIcon(FontAwesomeIcons.arrowRight),
        SizedBox(width: _size.width / 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              endDate,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ],
    );
