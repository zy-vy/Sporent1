import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import '/firebase_options.dart';
import 'package:sporent/screens/color.dart';

class EditUsernameRenter extends StatefulWidget {
  const EditUsernameRenter({super.key});

  @override
  State<EditUsernameRenter> createState() => _EditUsernameRenterState();
}

class _EditUsernameRenterState extends State<EditUsernameRenter> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

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
                EdgeInsets.symmetric(vertical: _size.height/30, horizontal: _size.width/18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Edit Your Username",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: _size.height/50),
                Text("Enter a username for your apps",
                    style: TextStyle(fontSize: 13, color: HexColor("979797"))),
                SizedBox(height: _size.height/30),
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your username',),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Username must not be empty";
                    }
                  },
                ),
                SizedBox(height: _size.height/20),
                SizedBox(
                    width: _size.width,
                    height: _size.height/15,
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
