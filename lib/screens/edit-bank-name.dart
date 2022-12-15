import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/screens/deposit-detail.dart';
import '../component/edit-page.dart';

class EditBankName extends StatelessWidget {
  const EditBankName({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
          child: const Text("Edit Bank Name"),
        ),
        backgroundColor: HexColor("4164DE"),
      ),
      body: const EditPage("Edit Your Bank Name", "Enter a bank name for deposit", "Enter your bank name", "Bank Name", DepositDetail())
    );
  }
}
