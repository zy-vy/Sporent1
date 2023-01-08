import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sporent/component/edit-page.dart';
import 'package:sporent/screens/color.dart';
import 'package:sporent/screens/edit-personal-info.dart';

class EditPhone extends StatelessWidget {
  const EditPhone({super.key});

  @override
  Widget build(BuildContext context) {
     final TextEditingController controllerPhoneNumber =
        TextEditingController();

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Edit Phone Number"),
          ),  
          backgroundColor: hexStringToColor("4164DE"),
        ),
        body: EditPage("Edit Your Phone Number", "Enter phone number for your apps", "Enter your Phone Number", "Phone Number", controllerPhoneNumber, EditPersonalInfo())

  );
  }
}