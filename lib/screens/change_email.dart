import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/edit_page.dart';
import 'package:sporent/screens/bottom_bar.dart';
import 'package:sporent/screens/color.dart';
import 'package:sporent/screens/profile.dart';
import 'package:sporent/screens/signin_screen.dart';

class EditEmail extends StatefulWidget {
  const EditEmail(this.email, this.password, this.id, {super.key});

  final String email;
  final String password;
  final String id;

  @override
  State<EditEmail> createState() => _EditEmailState();
}

class _EditEmailState extends State<EditEmail> {
  String? textPassword;
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Change Password"),
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
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    emailController.text = snapshot.data!.get("email");
                    emailController.selection = TextSelection.fromPosition(
                        TextPosition(offset: emailController.text.length));
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        topPage("New Email", _size,
                            "Create a new email for your account"),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter new email',
                          ),
                          validator: (value) {
                            if (value!.contains('@') == false) {
                              return "Invalid email";
                            }
                          },
                        ),
                        SizedBox(height: _size.height / 20),
                        SizedBox(
                            width: _size.width,
                            height: _size.height / 15,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  FirebaseFirestore.instance
                                                  .collection("user")
                                                  .doc(widget.id)
                                                  .update({
                                                "email": emailController.text
                                              });
                                              
                                  FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: widget.email,
                                          password: widget.password)
                                      .then((value) async {
                                    
                                    final currentUser =
                                        FirebaseAuth.instance.currentUser;
                                    await currentUser!
                                        .updateEmail(emailController.text)
                                        .then((value) => CoolAlert.show(
                                                    context: context,
                                                    type: CoolAlertType.success,
                                                    text:
                                                        "Success change email")
                                                .then((value) {
                                              FirebaseAuth.instance.signOut();
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const SignInScreen()));
                                            }))
                                        .catchError((onError) {
                                      CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.error,
                                          text: "Email error");
                                    });
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: HexColor("4164DE"),
                              ),
                              child: const Text("Confirm",
                                  textAlign: TextAlign.center),
                            ))
                      ],
                    );
                  }
                }),
          ),
        ));
  }
}
