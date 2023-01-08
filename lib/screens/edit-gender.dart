import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/screens/edit-personal-info.dart';
import '../component/edit-page.dart';
import '/firebase_options.dart';
import 'package:sporent/screens/color.dart';

class EditGender extends StatelessWidget {
  const EditGender({super.key});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    final TextEditingController controllerGender =
        TextEditingController();

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Edit Gender"),
          ),  
          backgroundColor: hexStringToColor("4164DE"),
        ),
        body: EditPage("Edit Your Gender", "Enter gender for your apps", "Enter your Gender", "Gender", controllerGender, EditPersonalInfo())
  );
  }
}