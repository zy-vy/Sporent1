import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sporent/screens/add_product.dart';
import 'package:sporent/screens/manage_balance_admin.dart';

import '../component/field_row.dart';
import '../model/request.dart';

class DetailInformation extends StatelessWidget {
  const DetailInformation(this.request, {super.key});

  final Request request;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    NumberFormat currencyFormatter =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Balance Detail"),
          ),
          backgroundColor: HexColor("4164DE"),
        ),
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: _size.width / 15, vertical: _size.height / 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Bank Information",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              SizedBox(height: _size.height / 30),
              FieldRow("Bank Name", request.bank_name!, true, 14,
                  FontWeight.normal, FontWeight.w600),
              SizedBox(height: _size.height / 30),
              FieldRow("Account Number", request.account_number!, true, 14,
                  FontWeight.normal, FontWeight.w600),
              SizedBox(height: _size.height / 30),
              FieldRow("Account Name", request.account_name!, true, 14,
                  FontWeight.normal, FontWeight.w600),
              SizedBox(height: _size.height / 30),
              FieldRow("Amount", currencyFormatter.format(request.amount), true,
                  14, FontWeight.normal, FontWeight.w600),
              SizedBox(height: _size.height / 30),
              SizedBox(
                  width: _size.width,
                  height: _size.height / 15,
                  child: ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("request")
                          .doc(request.id)
                          .update({"status": "Finished"});

                      CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              text: "Success return balance...")
                          .then((value) => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const ManageBalance(),
                                ),
                              ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor("4164DE"),
                    ),
                    child: const Text("Confirm", textAlign: TextAlign.center),
                  ))
            ],
          ),
        ));
  }
}
