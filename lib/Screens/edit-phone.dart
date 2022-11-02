import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'firebase_options.dart';
import 'package:skripsi_sporent/color.dart';

class EditPhone extends StatelessWidget {
  const EditPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Edit Phone Number"),
          ),  
          backgroundColor: hexStringToColor("4164DE"),
        ),
        body: Padding(
      padding: const EdgeInsets.only(top: 30, left: 20, right: 35, bottom: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Edit Your Phone Number",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text("Enter phone number for your apps", style: TextStyle(fontSize: 13, color: HexColor("979797"))),
          const SizedBox(height: 30),
          IntlPhoneField(
             decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your phone number'
            ),
            initialCountryCode: 'ID',
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: 370,
            height: 55,
            child: ElevatedButton(
            onPressed: (){},
            style: ElevatedButton.styleFrom(
              backgroundColor: HexColor("4164DE"),
              // padding: const EdgeInsets.only(right: 300, bottom: 40)
            ), 
            child: const Text("Confirm", textAlign: TextAlign.center),)
          )
        ],
      ),
    ),
  );
  }
}