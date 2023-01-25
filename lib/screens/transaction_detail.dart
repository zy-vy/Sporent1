import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sporent/screens/complain_detail.dart';
import 'package:sporent/screens/complain_product.dart';
import 'package:sporent/screens/condition_check_before_user.dart';
import 'package:sporent/screens/return_product.dart';
import 'package:sporent/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../component/transaction_card_detail.dart';
import '../component/field_row.dart';
import '../model/transaction.dart';

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

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    var dateFormat = DateFormat('d MMMM ' 'yyyy');
    NumberFormat currencyFormatter =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
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
                  final Uri _url = Uri.parse(transaction.tracking_code_owner??"");
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
                              child: Text(transaction.tracking_code_owner??"",
                                  style: const TextStyle(
                                      color: Colors.blueAccent)),
                              onTap: () async => await launchUrl(_url),
                            ),
                      SizedBox(height: _size.height / 40),
                      Divider(color: hexStringToColor("E0E0E0"), thickness: 2),
                      SizedBox(height: _size.height / 40),
                      const Text("Condition Check",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      SizedBox(height: _size.height / 40),
                      TextButton(
                          style: TextButton.styleFrom(
                              side: BorderSide(
                                  width: 1, color: HexColor("888888"))),
                          onPressed: transaction.status == "WAITING"
                              ? null
                              : transaction.status == "CONFIRM"
                                  ? null
                                  : transaction.status == "ACCEPT" ? null
                                  : () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) =>
                                              ConditionCheckBeforeUser(
                                                  transaction.id!,
                                                  transaction
                                                      .image_before_user??"",
                                                  transaction
                                                      .description_before_user??"")));
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Pre-Condition",
                                      style: TextStyle(
                                          color: transaction.status == "WAITING"
                                              ? Colors.grey 
                                              : transaction.status == "ACCEPT" ? Colors.grey : transaction.status == "CONFIRM"
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
                                        : transaction.status == "ACTIVE"
                                            ? const Text(
                                                "This check has been completed",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13),
                                              )
                                            : transaction.status == "RETURN" ? const Text(
                                                "This check has been completed",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13),
                                              ) : const Text(
                                                "This check is not ready at this time",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 13),
                                              )
                                  ],
                                )),
                                FaIcon(FontAwesomeIcons.chevronRight,
                                    color: transaction.status == "WAITING"
                                              ? Colors.grey 
                                              : transaction.status == "ACCEPT" ? Colors.grey : transaction.status == "CONFIRM"
                                                  ? Colors.grey
                                                  : Colors.black,
                                    size: 20)
                              ],
                            ),
                          )),
                      transaction.image_after_user != null ? SizedBox(height: _size.height / 30) : SizedBox(height: _size.height / 20),
                      transaction.image_after_user != null
                          ? TextButton(
                              style: TextButton.styleFrom(
                                  side: BorderSide(
                                      width: 1, color: HexColor("888888"))),
                              onPressed: transaction.status == "WAITING"
                                  ? null
                                  : transaction.status == "CONFIRM"
                                      ? null
                                      : () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReturnProduct(
                                                          transaction.id!,
                                                          transaction
                                                              .image_after_user??"",
                                                          transaction.tracking_code_user??"",
                                                          idOwner: "")));
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
                                        const Text(
                                          "Post-Condition",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        SizedBox(height: _size.height / 80),
                                        const Text(
                                          "This check has been completed",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13),
                                        )
                                      ],
                                    )),
                                    FaIcon(FontAwesomeIcons.chevronRight,
                                        color: transaction.status == "WAITING"
                                            ? null
                                            : transaction.status == "CONFIRM"
                                                ? Colors.grey
                                                : Colors.black,
                                        size: 20)
                                  ],
                                ),
                              ))
                          : const SizedBox(),
                      transaction.image_after_user != null
                          ? const SizedBox()
                          : SizedBox(
                              width: _size.width,
                              height: _size.height / 12,
                              child: ElevatedButton(
                                onPressed:
                                dateFormat
                                            .format(transaction.end_date!) !=
                                        dateFormat.format(DateTime.now())
                                    ? null
                                    :
                                transaction.status != "ACTIVE"
                                        ? null
                                        : () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReturnProduct(
                                                          idOwner: transaction.owner!.id,
                                                          transaction.id!,
                                                          "",
                                                          "")),
                                            );
                                          },
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
                      transaction.image_after_user != null
                          ? const SizedBox()
                          : Center(
                              child: TextButton(
                                  onPressed: transaction.status != "ACTIVE"
                                      ? null
                                      : () {
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
                                                          transaction.total!, "user")),
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
                                        },
                                  child: Text(
                                    "Complain Product",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: transaction.status == "ACTIVE"
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
