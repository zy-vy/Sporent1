import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/screens/edit-personal-info-renter.dart';
import '../component/edit-page.dart';

class EditDescriptionRenter extends StatelessWidget {
  const EditDescriptionRenter({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
          child: const Text("Edit Description"),
        ),
        backgroundColor: HexColor("4164DE"),
      ),
      body: const EditPage("Edit Your Description", "Enter a description for your page", "Enter your Description", "Description", EditPersonalInfoRenter())
    );
  }
}
