import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/screens/profile-renter.dart';
import '/firebase_options.dart';
import 'package:sporent/screens/color.dart';

class InputRenterName extends StatefulWidget {
  const InputRenterName({super.key});

  @override
  State<InputRenterName> createState() => _InputRenterNameState();
}

class _InputRenterNameState extends State<InputRenterName> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
          child: const Text("Input Renter Information"),
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
              "Renter Name",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text("Enter a unique name for your page",
                style: TextStyle(fontSize: 13, color: HexColor("979797"))),
            const SizedBox(height: 30),
            const TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Enter your name'),
            ),
            const SizedBox(height: 40),
            SizedBox(
                width: 370,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const RenterProfile()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor("4164DE"),
                    // padding: const EdgeInsets.only(right: 300, bottom: 40)
                  ),
                  child: const Text("Confirm", textAlign: TextAlign.center),
                )),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text("Terms & Condition",
                        style: TextStyle(
                            color: HexColor("4164DE"),
                            fontWeight: FontWeight.w600,
                            fontSize: 16))),
                const Text("and",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16)),
                TextButton(
                    onPressed: () {},
                    child: Text("Privacy Policy",
                        style: TextStyle(
                            color: HexColor("4164DE"),
                            fontWeight: FontWeight.w600,
                            fontSize: 16))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
