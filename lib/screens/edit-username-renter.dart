import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/edit-page.dart';
import 'package:sporent/screens/edit-personal-info-renter.dart';
import '/firebase_options.dart';
import 'package:sporent/screens/color.dart';

class EditUsernameRenter extends StatefulWidget {
  const EditUsernameRenter({super.key});

  @override
  State<EditUsernameRenter> createState() => _EditUsernameRenterState();
}

class _EditUsernameRenterState extends State<EditUsernameRenter> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
          child: const Text("Edit Username"),
        ),
        backgroundColor: hexStringToColor("4164DE"),
      ),
      body: const EditPage("Edit Your Username", "Enter a username for your page", "Enter your Username", "Username", EditPersonalInfoRenter())
    );
  }
}
