import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sporent/screens/color.dart';

class EditBirthdate extends StatefulWidget {
  const EditBirthdate({super.key});

  @override
  State<EditBirthdate> createState() => _EditBirthdateState();
}

class _EditBirthdateState extends State<EditBirthdate> {
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
          child: const Text("Edit Birthdate"),
        ),
        backgroundColor: hexStringToColor("4164DE"),
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(vertical: _size.height/30, horizontal: _size.width/18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Edit Your Birthdate",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: _size.height/50),
            Text("Select birthdate for your apps",
                style: TextStyle(fontSize: 13, color: HexColor("979797"))),
            SizedBox(height: _size.height/30),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select your birthdate'),
              readOnly: true,
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1800),
                    lastDate: DateTime(2100));

                if (selectedDate != null) {
                  String formattedDate =
                      DateFormat('d MMMM ''yyyy').format(selectedDate);

                  setState(() {
                    dateController.text = formattedDate;
                  });
                } else {
                  print("Date is not selected");
                }
              },
            ),
            SizedBox(height: _size.height/20),
            SizedBox(
                width: _size.width,
               height: _size.height/15,
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
