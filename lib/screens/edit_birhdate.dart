import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sporent/component/edit_page.dart';
import 'package:sporent/screens/color.dart';
import 'package:sporent/screens/edit_personal_info.dart';

class EditBirthdate extends StatefulWidget {
  const EditBirthdate(this.id, {super.key});

  final String id;

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
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("user")
                    .doc(widget.id)
                    .snapshots(),
                builder: (context, snapshot) {
                  if(dateController.text.isEmpty == true){
                    dateController.text = snapshot.data!.get("birthdate");
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      topPage("Edit Your Birhdate", _size,
                          "Select birthdate for your apps"),
                      TextFormField(
                        readOnly: true,
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
                            String formattedDate = DateFormat('d MMMM ' 'yyyy')
                                .format(selectedDate);

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
                      bottomPageUpdate(_size, _formKey, "birthdate" , "Birthdate", widget.id, context, EditPersonalInfo(widget.id), dateController)
                    ],
                  );
                }),
          ),
        ));
  }
}
