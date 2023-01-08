import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/edit-page.dart';
import 'package:sporent/screens/edit-personal-info-renter.dart';

class EditAddress extends StatelessWidget {
  const EditAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controllerAddress =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
          child: const Text("Edit Address"),
        ),
        backgroundColor: HexColor("4164DE"),
      ),
      body:  EditPage("Edit Your Address", "Enter address for your page", "Enter your address", "Address", controllerAddress, const EditPersonalInfoRenter())
    );
  }
}
