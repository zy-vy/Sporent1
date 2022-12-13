import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/component-edit.dart';
import 'package:sporent/component/detail-product-card.dart';
import 'package:sporent/screens/color.dart';
import 'package:sporent/screens/edit-account-number.dart';
import 'package:sporent/screens/edit-bank-name.dart';

class DepositDetail extends StatefulWidget {
  const DepositDetail({super.key});

  @override
  State<DepositDetail> createState() => _DepositDetailState();
}

class _DepositDetailState extends State<DepositDetail> {
  TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Deposit Information"),
          ),
          backgroundColor: hexStringToColor("4164DE"),
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(top: _size.height / 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: _size.width / 20, bottom: _size.height / 80),
                child: const Text(
                  "Status: In Progress",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Divider(
                thickness: 2,
                color: HexColor("E0E0E0"),
              ),
              const DetailProductCard(20, 19, 15, 18, "Total Deposit"),
              bankInformation(_size)
            ],
          ),
        ));
  }
}

Padding bankInformation(Size _size) => Padding(
    padding: EdgeInsets.only(
        top: _size.height / 50,
        left: _size.width / 20,
        bottom: _size.height / 60,
        right: _size.width / 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Bank Information",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: _size.height / 50),
        const FieldForm("Bank Name", "BCA", EditBankName(), 15, 15, 5, true),
        const FieldForm("Account Number", "0211276484758", EditAccountNumber(),
            15, 15, 10, true),
      ],
    ));
