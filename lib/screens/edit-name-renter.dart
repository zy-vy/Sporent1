import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import '/firebase_options.dart';
import 'package:sporent/screens/color.dart';

class EditNameRenter extends StatefulWidget {
  const EditNameRenter({super.key});

  @override
  State<EditNameRenter> createState() => _EditNameRenterState();
}

class _EditNameRenterState extends State<EditNameRenter> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
          child: const Text("Edit Name"),
        ),
        backgroundColor: hexStringToColor("4164DE"),
      ),
      body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 30, left: 20, right: 35, bottom: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Edit Your Name",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text("Enter a name for your apps",
                    style: TextStyle(fontSize: 13, color: HexColor("979797"))),
                const SizedBox(height: 30),
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your name',),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name must not be empty";
                    }
                  },
                ),
                const SizedBox(height: 40),
                SizedBox(
                    width: 370,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        final isValidForm = _formKey.currentState!.validate();
                        // if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(content: Text('Processing Data')),
                        // );
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("4164DE"),
                        // padding: const EdgeInsets.only(right: 300, bottom: 40)
                      ),
                      child: const Text("Confirm", textAlign: TextAlign.center),
                    ))
              ],
            ),
          )),
    );
  }
}
