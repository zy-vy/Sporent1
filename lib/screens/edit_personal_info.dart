import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/component-edit.dart';
import 'package:sporent/model/user.dart';
import 'package:sporent/screens/edit_birhdate.dart';

import '../component/edit_page.dart';

class EditPersonalInfo extends StatefulWidget {
  const EditPersonalInfo(this.id, {super.key});

  final String id;

  @override
  State<EditPersonalInfo> createState() => _EditPersonalInfoState();
}

class _EditPersonalInfoState extends State<EditPersonalInfo> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPhoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //   icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          //   onPressed: () {
          //     Navigator.of(context)
          //         .push(MaterialPageRoute(builder: (context) => const ProfilePage()));
          //   },
          // ),
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
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("user")
                  .doc(widget.id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  var docUser = UserLocal.fromDocument(
                      snapshot.data!.id, snapshot.data!.data()!);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Profile Info",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: _size.height / 50),
                      FieldForm(
                          "Username",
                          docUser.name.toString(),
                          EditPage(
                              widget.id,
                              "Edit Your Username",
                              "Enter a username for your apps",
                              "Enter your Username",
                              "Username",
                              "name",
                              controllerUsername,
                              EditPersonalInfo(widget.id)),
                          16,
                          12,
                          5,
                          true),
                      Divider(color: HexColor("E6E6E6"), thickness: 2),
                      SizedBox(height: _size.height / 40),
                      const Text(
                        "Personal Info",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: _size.height / 50),
                      FieldForm(
                          "Email",
                          docUser.email.toString(),
                          EditPage(
                              widget.id,
                              "Edit Your Email",
                              "Enter a email for your page",
                              "Enter your Email",
                              "Email",
                              "email",
                              controllerEmail,
                              EditPersonalInfo(widget.id)),
                          16,
                          12,
                          3.5,
                          true),
                      FieldForm(
                          "Phone Number",
                          docUser.phoneNumber.toString(),
                          EditPage(
                              widget.id,
                              "Edit Your Phone Number",
                              "Enter phone number for your apps",
                              "Enter your Phone Number",
                              "Phone Number",
                              "phone_number",
                              controllerPhoneNumber,
                              EditPersonalInfo(widget.id)),
                          16,
                          12,
                          9.2,
                          true),
                      FieldForm("Birthdate", docUser.birthdate.toString(),
                          EditBirthdate(widget.id), 16, 12, 4.6, true),
                    ],
                  );
                }
              }),
        ));
  }
}
