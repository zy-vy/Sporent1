import 'package:flutter/material.dart';
import 'package:sporent/screens/edit-personal-info.dart';
import '../component/edit-page.dart';
import 'package:sporent/screens/color.dart';

class EditUsername extends StatelessWidget {
  const EditUsername({super.key});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Edit Username"),
          ),  
          backgroundColor: hexStringToColor("4164DE"),
        ),
        body: const EditPage("Edit Your Username", "Enter a username for your apps", "Enter your Username", "Username", EditPersonalInfo())
    );
  }
}