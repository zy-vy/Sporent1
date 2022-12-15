import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sporent/component/edit-page.dart';
import 'package:sporent/screens/color.dart';
import 'package:sporent/screens/edit-personal-info.dart';

class EditBirthdate extends StatefulWidget {
  const EditBirthdate({super.key});

  @override
  State<EditBirthdate> createState() => _EditBirthdateState();
}

class _EditBirthdateState extends State<EditBirthdate> {
  TextEditingController dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
            topPage(
                "Edit Your Birhdate", _size, "Select birthdate for your apps"),
            TextFormField(
              controller: dateController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select your birthdate'),
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1800),
                    lastDate: DateTime(2100));

                if (selectedDate != null) {
                  String formattedDate =
                      DateFormat('d MMMM ' 'yyyy').format(selectedDate);

                  setState(() {
                    dateController.text = formattedDate;
                  });
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Date must not be empty";
                }
              },
            ),
            bottomPage(_size, _formKey, context, const EditPersonalInfo())
          ],
        ),
      ),
    ));
  }
}
