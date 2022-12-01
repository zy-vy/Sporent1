import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import '/firebase_options.dart';
import 'package:sporent/screens/color.dart';

class EditGender extends StatelessWidget {
  const EditGender({super.key});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Edit Gender"),
          ),  
          backgroundColor: hexStringToColor("4164DE"),
        ),
        body: Padding(
      padding: EdgeInsets.symmetric(vertical: _size.height/30, horizontal: _size.width/18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Edit Your Gender",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: _size.height/50),
          Text("Select your gender", style: TextStyle(fontSize: 13, color: HexColor("979797"))),
          SizedBox(height: _size.height/30),
          DropdownButtonFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Select gender'
            ), 
            items: const [
              DropdownMenuItem(value: "Male",child: Text("Male")),
              DropdownMenuItem(value: "Female",child: Text("Female"))
            ], 
            onChanged: (value) {  },
          ),

          SizedBox(height: _size.height/20),
          SizedBox(
            width: _size.width,
            height: _size.height/15,
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