import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/edit_page.dart';
import 'package:sporent/screens/change_email.dart';
import 'package:sporent/screens/change_password.dart';
import 'package:sporent/screens/color.dart';

class PasswordConfirmation extends StatefulWidget {
  const PasswordConfirmation(this.email, this.page, {super.key, this.id});

  final String email;
  final String page;
  final String? id;

  @override
  State<PasswordConfirmation> createState() => _PasswordConfirmationState();
}

class _PasswordConfirmationState extends State<PasswordConfirmation> {
  bool hidePassword = true;
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
            child: const Text("Password Confirmation"),
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
                topPage("Password confirmation", _size,
                    "Enter your password to confirm your identity"),
                TextFormField(
                  controller: passController,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Enter password',
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
                    hintText: "Enter password",
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
                  },
                ),
                SizedBox(height: _size.height / 20),
                SizedBox(
                    width: _size.width,
                    height: _size.height / 15,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: widget.email,
                                  password: passController.text)
                              .then((value) {
                            if (widget.page == "password") {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditPassword(
                                          widget.email, passController.text)));
                            } else {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditEmail(
                                            widget.email,
                                            passController.text,
                                            widget.id!
                                          )));
                            }
                          }).onError((error, stackTrace) {
                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.error,
                                text: "Password not match.");
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("4164DE"),
                      ),
                      child: const Text("Confirm", textAlign: TextAlign.center),
                    ))
              ],
            ),
          ),
        ));
  }
}
