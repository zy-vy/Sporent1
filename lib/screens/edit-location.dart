import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/edit-page.dart';
import 'package:sporent/screens/edit-personal-info-renter.dart';

class EditLocationRenter extends StatelessWidget {
  const EditLocationRenter({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
          child: const Text("Edit Location"),
        ),
        backgroundColor: HexColor("4164DE"),
      ),
      body: const EditPage("Edit Your Location", "Enter a location for your page", "Enter your location", "Location", EditPersonalInfoRenter())
    );
  }
}
