import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:skripsi_sporent/Screens/color.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({super.key});

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  bool hidePassword = true;
  bool hidePasswordConfirm = true;
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
          child: const Text("Change Password"),
        ),
        backgroundColor: hexStringToColor("4164DE"),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 30, left: 20, right: 35, bottom: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "New Password",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text("Create a new strong password for your email",
                style: TextStyle(fontSize: 13, color: HexColor("979797"))),
            const SizedBox(height: 15),
            TextField(
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
                  errorText: "Minimum 8 characters",
                  errorStyle: const TextStyle(color: Colors.grey),
                  errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedErrorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent)) 
                  ),
            ),
            const SizedBox(height: 20),
            TextField(
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
            ),
            const SizedBox(height: 40),
            SizedBox(
                width: 370,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor("4164DE"),
                  ),
                  child: const Text("Confirm", textAlign: TextAlign.center),
                ))
          ],
        ),
      ),
    );
  }
}

String? validatePassword(String value) {
  if (!(value.length > 8)) {
    return "Password is too short, should more than 8 characters";
  }
  return null;
}
