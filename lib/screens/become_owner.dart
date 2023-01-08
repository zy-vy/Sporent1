import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/edit-page.dart';
import 'package:sporent/screens/add-product-renter.dart';
import 'package:sporent/screens/privacy_policy.dart';
import 'package:sporent/screens/profile-renter.dart';
import 'package:sporent/screens/terms_and_condition.dart';

class BecomOwner extends StatefulWidget {
  const BecomOwner({super.key});

  @override
  State<BecomOwner> createState() => _BecomOwnerState();
}

class _BecomOwnerState extends State<BecomOwner> {
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
        resizeToAvoidBottomInset: false,
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
                    bottomPage(_size, _formKey, context, const RenterProfile()),
                  ],
                ),
              ]),
            )));
  }
}
