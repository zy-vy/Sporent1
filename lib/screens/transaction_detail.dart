import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sporent/screens/complainproduct.dart';
import 'package:sporent/screens/returnproduct.dart';
import 'package:sporent/screens/signin_screen.dart';
import 'package:sporent/screens/transaction_screen.dart';
import 'package:sporent/utils/colors.dart';

import '../component/transaction_card_detail.dart';
import '../component/field_row.dart';
import '../model/transaction.dart';

class DetailTransaction extends StatefulWidget {
  const DetailTransaction(this.id, this.product_image, this.product_name,
      {super.key});

  final String id;
  final String product_image;
  final String product_name;

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
                  .doc(widget.id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  TransactionModel transaction = TransactionModel.fromDocument(
                      snapshot.data!.id, snapshot.data!.data()!);
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
                      bookingPeriod(
                          dateFormat.format(transaction.start_date!),
                          dateFormat.format(transaction.end_date!),
                          _size),
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
                      SizedBox(height: _size.height / 50),
                      const Text(
                        "Delivery Information",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: _size.height / 40),
                      FieldRow(
                          "Delivery Type",
                          transaction.delivery_method!,
                          true,
                          15,
                          FontWeight.normal,
                          FontWeight.w500),
                      SizedBox(height: _size.height / 70),
                      FieldRow("Address", transaction.delivery_location!,
                          true, 15, FontWeight.normal, FontWeight.w500),
                      SizedBox(height: _size.height / 40),
                      Divider(color: hexStringToColor("E0E0E0"), thickness: 2),
                      SizedBox(height: _size.height / 40),
                      const Text("Live Tracking Gojek",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
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
                          onPressed: transaction.status == "Not Confirm"
                              ? null
                              : () {},
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
                                    const Text(
                                      "Pre-Condition",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    SizedBox(height: _size.height / 80),
                                    transaction.status == "Not Confirm"
                                        ? const Text(
                                            "This check is not ready at this time",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13),
                                          )
                                        : const Text(
                                            "This check is ready, you can input your product image",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13),
                                          )
                                  ],
                                )),
                                const FaIcon(FontAwesomeIcons.chevronRight,color: Colors.black,
                                    size: 20)
                              ],
                            ),
                          )),
                      SizedBox(height: _size.height / 40),
                      TextButton(
                        onPressed: (){}, 
                        child: Text("Complain Product", style: TextStyle(fontSize: 14,color: HexColor("4164DE"), fontWeight: FontWeight.bold),))
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
