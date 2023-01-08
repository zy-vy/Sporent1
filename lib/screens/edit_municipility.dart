import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/edit-page.dart';
import 'package:sporent/screens/edit-personal-info-renter.dart';

class EditMunicipality extends StatelessWidget {
  const EditMunicipality({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controllerMunicipility =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
          child: const Text("Edit Municipality"),
        ),
        backgroundColor: HexColor("4164DE"),
      ),
      body:  EditPage("Edit Your Municipality", "Enter municipality for your page", "Enter your municipality", "Municipality", controllerMunicipility, const EditPersonalInfoRenter())
    );
  }
}
