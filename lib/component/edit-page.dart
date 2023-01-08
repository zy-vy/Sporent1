import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class EditPage extends StatefulWidget {
  const EditPage(
      this.titleForm, this.descForm, this.labelText, this.type, this.controller, this.page,
      {super.key});

  final String titleForm;
  final String descForm;
  final String labelText;
  final String type;
  final TextEditingController controller;
  final Widget page;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: _size.height / 30, horizontal: _size.width / 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topPage(widget.titleForm, _size, widget.descForm),
              widget.type == "Phone Number"
                  ? fieldPhoneForm(widget.labelText)
                  : widget.type == "Gender"
                      ? fieldGenderForm()
                      : fieldTextForm(widget.labelText, widget.type, widget.controller),
              bottomPage(_size, _formKey, context, widget.page)
            ],
          ),
        ));
  }
}

TextFormField fieldTextForm(
        String label, String type, TextEditingController controller) =>
    TextFormField(
      controller: controller,
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 5,
      decoration:
          InputDecoration(border: const OutlineInputBorder(), labelText: label),
      validator: ((value) {
        if (value!.isEmpty) {
          return "${type} must not be empty";
        }
        if (type == "Email") {
          if (!value.contains("@") || !value.endsWith("gmail.com")) {
            return "Invalid Email";
          }
        }
      }),
    );

IntlPhoneField fieldPhoneForm(String labelText) => IntlPhoneField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Enter your phone number'),
      initialCountryCode: 'ID',
      disableLengthCheck: true,
      validator: ((p0) {
        if (p0!.number.isEmpty) {
          return "Phone Number must not be empty";
        }
        if (p0.number.length > 11) {
          return "Invalid Phone Number";
        }
      }),
    );
DropdownButtonFormField fieldGenderForm() => DropdownButtonFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Select gender'),
      items: const [
        DropdownMenuItem(value: "Male", child: Text("Male")),
        DropdownMenuItem(value: "Female", child: Text("Female"))
      ],
      validator: (value) {
        if (value == null) {
          return "Gender must not be empty";
        }
      },
      onChanged: (value) {},
    );

Column topPage(String title, Size _size, String desc) => Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: _size.height / 50),
        Text(desc, style: TextStyle(fontSize: 13, color: HexColor("979797"))),
        SizedBox(height: _size.height / 30),
      ],
    );

Column bottomPage(Size _size, GlobalKey<FormState> _formKey,
        BuildContext context, Widget page) =>
    Column(
      children: [
        SizedBox(height: _size.height / 20),
        SizedBox(
            width: _size.width,
            height: _size.height / 15,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => page,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: HexColor("4164DE"),
              ),
              child: const Text("Confirm", textAlign: TextAlign.center),
            ))
      ],
    );
