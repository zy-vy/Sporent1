import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/edit_page.dart';
import 'package:sporent/screens/color.dart';
import 'package:sporent/screens/profile.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({super.key});

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  bool hidePassword = true;
  bool hidePasswordConfirm = true;
  String? textPassword;
  TextEditingController passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Change Password"),
          ),
          backgroundColor: hexStringToColor("4164DE"),
        ),
        resizeToAvoidBottomInset: false,
        body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: _size.height / 30, horizontal: _size.width / 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                topPage("New Password", _size,
                    "Create a new strong password for your email"),
                TextFormField(
                  controller: passController,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Enter new password',
                    suffixIcon: IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        icon: FaIcon(
                            hidePassword == true
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            size: 20)),
                    hintText: "Minimum 8 characters",
                  ),
                  onEditingComplete: () {
                    setState(() {
                      textPassword = passController.text;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password must not be empty";
                    }
                    if (!(value.length > 8)) {
                      return "Password is too short, should more than 8 characters";
                    }
                  },
                ),
                SizedBox(height: _size.height / 40),
                TextFormField(
                  obscureText: hidePasswordConfirm,
                  decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      labelText: 'Confirm new password',
                      suffixIcon: IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            setState(() {
                              hidePasswordConfirm = !hidePasswordConfirm;
                            });
                          },
                          icon: FaIcon(
                              hidePasswordConfirm == true
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash,
                              size: 20))),
                  validator: (value) {
                    if (value != passController.text) {
                      return "Password must same with new password";
                    }
                  },
                ),
                bottomPage(_size, _formKey, context, const ProfilePage())
              ],
            ),
          ),
        ));
  }
}
