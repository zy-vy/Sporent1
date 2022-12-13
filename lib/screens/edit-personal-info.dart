import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/component-edit.dart';
import 'package:sporent/screens/edit-phone.dart';
import 'package:sporent/screens/edit-username.dart';
import 'package:sporent/screens/edit-email.dart';
import 'package:sporent/screens/edit-gender.dart';
import 'package:sporent/screens/edit-birhdate.dart';

class EditPersonalInfo extends StatelessWidget {
  const EditPersonalInfo({super.key});

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
          backgroundColor: HexColor("4164DE"),
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
              const FieldForm("Username", "Nasrul Ramadhan", EditUsername(), 16, 12, 5, true),
              Divider(color: HexColor("E6E6E6"), thickness: 2),
              SizedBox(height: _size.height / 40),
              const Text(
              "Personal Info",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: _size.height / 50),
              const FieldForm("Email","nasrul24@gmail.com", EditEmail(), 16, 12, 3.5, true),
              const FieldForm("Phone Number","Input phone number", EditPhone(), 16, 12, 9.2, false),
              const FieldForm("Gender","Input gender", EditGender(), 16, 12, 3.9, false),
              const FieldForm("Birthdate","20 January 2001", EditBirthdate(), 16, 12, 4.6, true),

            ],
          ),
        ));
  }
}
