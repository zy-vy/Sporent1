import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/colors.dart';
import 'homepage.dart';

class SignUpScreenFinal extends StatefulWidget {
  const SignUpScreenFinal({super.key});

  @override
  State<SignUpScreenFinal> createState() => _SignUpScreenFinalState();
}

class _SignUpScreenFinalState extends State<SignUpScreenFinal> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _birthDateTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: hexStringToColor("4164DE")),
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                    child: Form(
                        key: formKey,
                        child: Column(children: <Widget>[
                          RichText(
                              text: const TextSpan(
                                  text: "Let's Create Your\nAccount\n\n",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  children: [
                                TextSpan(
                                  text:
                                      "Come and Explore Some Various Stuff!\n",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )
                              ])),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _userNameTextController,
                            obscureText: false,
                            enableSuggestions: !false,
                            autocorrect: !false,
                            cursorColor: Colors.white,
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.9)),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: Colors.white70,
                              ),
                              labelText: "Enter Username",
                              labelStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.9)),
                              filled: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              fillColor: Colors.white.withOpacity(0.3),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 0, style: BorderStyle.none)),
                            ),
                            keyboardType: true
                                ? TextInputType.visiblePassword
                                : TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                                return "Enter Correct Name";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _birthDateTextController,
                            obscureText: false,
                            enableSuggestions: !false,
                            autocorrect: !false,
                            cursorColor: Colors.white,
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.9)),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.white70,
                              ),
                              labelText: "Enter Birthdate",
                              labelStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.9)),
                              filled: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              fillColor: Colors.white.withOpacity(0.3),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 0, style: BorderStyle.none)),
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1800),
                                  lastDate: DateTime(2100));

                              if (selectedDate != null) {
                                String formattedDate =
                                    DateFormat('d MMMM ' 'yyyy')
                                        .format(selectedDate);

                                setState(() {
                                  _birthDateTextController.text = formattedDate;
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter the Birthdate";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _emailTextController,
                            obscureText: false,
                            enableSuggestions: !false,
                            autocorrect: !false,
                            cursorColor: Colors.white,
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.9)),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: Colors.white70,
                              ),
                              labelText: "Enter Email",
                              labelStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.9)),
                              filled: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              fillColor: Colors.white.withOpacity(0.3),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 0, style: BorderStyle.none)),
                            ),
                            keyboardType: false
                                ? TextInputType.visiblePassword
                                : TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}')
                                      .hasMatch(value!)) {
                                return "Enter Correct Email";
                              }
                              // ignore: unrelated_type_equality_checks
                              if (checkIfEmailInUse(value) == true) {
                                return 'Email is Already Taken';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _passwordTextController,
                            obscureText: true,
                            enableSuggestions: !true,
                            autocorrect: !true,
                            cursorColor: Colors.white,
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.9)),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.lock_outlined,
                                color: Colors.white70,
                              ),
                              labelText: "Enter Password",
                              labelStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.9)),
                              filled: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              fillColor: Colors.white.withOpacity(0.3),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 0, style: BorderStyle.none)),
                            ),
                            keyboardType: true
                                ? TextInputType.visiblePassword
                                : TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password Cannot be Empty";
                              }
                              if (value.length > 15) {
                                return "Password Too Long";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(90)),
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: _emailTextController.text,
                                          password:
                                              _passwordTextController.text)
                                      .then((value) {
                                    print("Created New Account");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen()));
                                  }).onError((error, stackTrace) {
                                    if (error.toString().contains("email")) {
                                      _showAlertDialog("Email Already In Use");
                                    }
                                    if (error.toString().contains("Password")) {
                                      _showAlertDialog(
                                          "Password minimum 6 Character");
                                    }
                                    print("Error ${error.toString()}");
                                  });
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return Colors.black26;
                                    }
                                    return Colors.white;
                                  }),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)))),
                              child: const Text(
                                'CREATE ACCOUNT',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          )
                        ]))))));
  }

  Future<bool> checkIfEmailInUse(String emailAddress) async {
    try {
      // Fetch sign-in methods for the email address
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);

      // In case list is not empty
      if (list.isNotEmpty) {
        // Return true because there is an existing
        // user using the email address
        return true;
      } else {
        // Return false because email adress is not in use
        return false;
      }
    } catch (error) {
      // Handle error
      // ...
      return true;
    }
  }

  void _showAlertDialog(String message) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
