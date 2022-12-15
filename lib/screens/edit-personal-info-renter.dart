import 'package:flutter/material.dart';
import 'package:sporent/component/component-edit.dart';
import 'package:sporent/screens/edit-description-renter2.dart';
import 'package:sporent/screens/edit-location.dart';
import 'package:sporent/screens/edit-username-renter.dart';
import 'package:sporent/screens/color.dart';

class EditPersonalInfoRenter extends StatelessWidget {
  const EditPersonalInfoRenter({super.key});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Edit Personal Info"),
          ),
          backgroundColor: hexStringToColor("4164DE"),
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: _size.height / 20, horizontal: _size.width / 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Profile Info",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: _size.height / 50),
              const FieldForm("Name", "Nasrul Ramadhan", EditUsernameRenter(), 16, 12, 5, true),
              const FieldForm("Location","Set location", EditLocationRenter(), 16, 12, 6.8, false),
              const FieldForm("Description","Input description", EditDescriptionRenter(), 16, 12, 10.5, false),

            ],
          ),
        ));
  }
}