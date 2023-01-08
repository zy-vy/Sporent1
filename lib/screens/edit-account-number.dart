import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/screens/deposit-detail.dart';
import '../component/edit-page.dart';

class EditAccountNumber extends StatelessWidget {
  const EditAccountNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controllerAccountNumber =
        TextEditingController();

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Edit Account Number"),
          ),
          backgroundColor: HexColor("4164DE"),
        ),
        body:EditPage(
            "Edit Your Account Number",
            "Enter account number for deposit",
            "Enter your account number",
            "Account Number",controllerAccountNumber,
            const DepositDetail()));
  }
}
