import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/edit_page.dart';
import 'package:sporent/model/owner.dart';
import 'package:sporent/screens/add_product.dart';
import 'package:sporent/screens/privacy_policy.dart';
import 'package:sporent/screens/profile_owner.dart';
import 'package:sporent/screens/terms_and_condition.dart';

class BecomeOwner extends StatefulWidget {
  const BecomeOwner(this.id, {super.key});

  final String? id;

  @override
  State<BecomeOwner> createState() => _BecomeOwnerState();
}

class _BecomeOwnerState extends State<BecomeOwner> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controllerOwnerName = TextEditingController();
  final TextEditingController controllerOwnerAddress = TextEditingController();
  final TextEditingController controllerOwnerMunicipality =
      TextEditingController();
  final TextEditingController controllerOwnerDescription =
      TextEditingController();
  bool? currValue = false;
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Input Owner Information"),
          ),
          backgroundColor: HexColor("4164DE"),
        ),
        body: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: _size.height / 30, horizontal: _size.width / 18),
              child: ListView(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    fieldText("Owner Name", "Enter owner name", _size,
                        controllerOwnerName),
                    fieldText("Owner Municipality", "Enter owner municipality",
                        _size, controllerOwnerMunicipality),
                    fieldText("Owner Address", "Enter owner address", _size,
                        controllerOwnerAddress),
                    fieldText("Owner Description", "Enter owner description",
                        _size, controllerOwnerDescription),
                    CheckboxListTileFormField(
                      contentPadding: EdgeInsets.zero,
                      title: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(children: <TextSpan>[
                            const TextSpan(
                                text:
                                    "By checking this box, you are confirming that you have read and agree ",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black)),
                            TextSpan(
                              text: "Terms & Condition ",
                              style: TextStyle(
                                  fontSize: 14, color: HexColor("4164DE")),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const TermsCondition()));
                                },
                            ),
                            const TextSpan(
                                text: "and ",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black)),
                            TextSpan(
                              text: "Privacy Policy ",
                              style: TextStyle(
                                  fontSize: 14, color: HexColor("4164DE")),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const PrivacyPolicy()));
                                },
                            ),
                          ])),
                      controlAffinity: ListTileControlAffinity.leading,
                      validator: (bool? value) {
                        if (value!) {
                          return null;
                        } else {
                          return 'Required!';
                        }
                      },
                    ),
                    Column(
                      children: [
                        SizedBox(height: _size.height / 20),
                        SizedBox(
                            width: _size.width,
                            height: _size.height / 15,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await FirebaseFirestore.instance
                                      .collection("user")
                                      .doc(widget.id)
                                      .update({
                                    "is_owner": true,
                                    "owner_name": controllerOwnerName.text,
                                    "owner_municipality":
                                        controllerOwnerMunicipality.text,
                                    "owner_address":
                                        controllerOwnerAddress.text,
                                    "owner_description":
                                        controllerOwnerDescription.text,
                                    "owner_image":
                                        "https://firebasestorage.googleapis.com/v0/b/sporent-80b28.appspot.com/o/user-images%2Ftemp.jpg?alt=media&token=e56c043d-8297-445d-8631-553d5cfbb0a6",
                                    "owner_balance": 0
                                  });

                                  CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.success,
                                          text: "Success become owner...")
                                      .then(
                                          (value) => Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      OwnerProfile(widget.id),
                                                ),
                                              ));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: HexColor("4164DE"),
                              ),
                              child: const Text("Confirm",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                            ))
                      ],
                    )
                  ],
                ),
              ]),
            )));
  }
}
