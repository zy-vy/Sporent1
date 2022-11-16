import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import '/firebase_options.dart';
import 'package:sporent/screens/color.dart';

class EditDescriptionRenter extends StatelessWidget {
  const EditDescriptionRenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
          child: const Text("Edit Description"),
        ),
        backgroundColor: HexColor("4164DE"),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 30, left: 20, right: 35, bottom: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Edit Description",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text("Enter a description for your apps",
                style: TextStyle(fontSize: 13, color: HexColor("979797"))),
            const SizedBox(height: 30),
            const TextField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your description'),
            ),
            const SizedBox(height: 40),
            SizedBox(
                width: 370,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor("4164DE"),
                    // padding: const EdgeInsets.only(right: 300, bottom: 40)
                  ),
                  child: const Text("Confirm", textAlign: TextAlign.center),
                ))
          ],
        ),
      ),
    );
  }
}
