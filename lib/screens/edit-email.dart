import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/screens/edit-personal-info.dart';
import '/firebase_options.dart';
import 'package:sporent/screens/color.dart';
import 'package:sporent/component/edit-page.dart';

class EditEmail extends StatelessWidget {
  const EditEmail({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Edit Email"),
          ),  
          backgroundColor: HexColor("4164DE"),
        ),
        body: const EditPage("Edit Your Email", "Enter a email for your page", "Enter your Email", "Email", EditPersonalInfo())
  );
  }
}