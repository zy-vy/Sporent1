import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../reusable_widgets/reusable_widget.dart';
import '../utils/colors.dart';
import 'homepage.dart';

class SignUpScreen extends StatefulWidget {
  // const SignUpScreen({super.key});
  const SignUpScreen({Key? key, required this.onSubmit}) : super(key: key);
  final ValueChanged<String> onSubmit;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _birthDateTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: formKey,
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
          child: Column(
            children: <Widget>[
              RichText(
                  text: const TextSpan(
                      text: "Let's Create Your\nAccount\n\n",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      children: [
                    TextSpan(
                      text: "Come and Explore Some Various Stuff!\n",
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
                style: TextStyle(color: Colors.white.withOpacity(0.9)),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Colors.white70,
                  ),
                  labelText: "Enter Username",
                  labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Colors.white.withOpacity(0.3),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none)),
                  // errorText: _errorTextUsername,
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  if (text.length < 4) {
                    return 'Too short';
                  }
                  return null;
                },
                // onChanged: (text) =>
                //     setState(() => _userNameTextController.text = text),
                keyboardType: false
                    ? TextInputType.visiblePassword
                    : TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _birthDateTextController,
                obscureText: false,
                enableSuggestions: !false,
                autocorrect: !false,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white.withOpacity(0.9)),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.white70,
                  ),
                  labelText: "Enter Birthdate",
                  labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Colors.white.withOpacity(0.3),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none)),
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
                        DateFormat('d MMMM ' 'yyyy').format(selectedDate);

                    setState(() {
                      _birthDateTextController.text = formattedDate;
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _emailTextController,
                obscureText: false,
                enableSuggestions: !false,
                autocorrect: !false,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white.withOpacity(0.9)),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.mail_outline_outlined,
                    color: Colors.white70,
                  ),
                  labelText: "Enter Email",
                  labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Colors.white.withOpacity(0.3),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none)),
                ),
                keyboardType: false
                    ? TextInputType.visiblePassword
                    : TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _passwordTextController,
                obscureText: true,
                enableSuggestions: !true,
                autocorrect: !true,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white.withOpacity(0.9)),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock_outlined,
                    color: Colors.white70,
                  ),
                  labelText: "Enter Password",
                  labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Colors.white.withOpacity(0.3),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none)),
                ),
                keyboardType: true
                    ? TextInputType.visiblePassword
                    : TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(90)),
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text)
                        .then((value) {
                      print("Created New Account");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage()));
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                    });
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black26;
                        }
                        return Colors.white;
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                  child: const Text(
                    'CREATE ACCOUNT',
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              )
              // SignInSignUpButton(context, false, () {
              //   FirebaseAuth.instance
              //       .createUserWithEmailAndPassword(
              //           email: _emailTextController.text,
              //           password: _passwordTextController.text)
              //       .then((value) {
              //     print("Created New Account");
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => HomeScreen()));
              //   }).onError((error, stackTrace) {
              //     print("Error ${error.toString()}");
              //   });
              // })
            ],
          ),
        )),
      ),
    );
  }

  // String? get _errorTextUsername {
  //   // at any time, we can get the text from _controller.value.text
  //   final text = _userNameTextController.value.text;
  //   // Note: you can do your own custom validation here
  //   // Move this logic this outside the widget for more testable code
  //   if (text.isEmpty) {
  //     return 'Can\'t be empty';
  //   }
  //   if (text.length < 4) {
  //     return 'Too short';
  //   }
  //   // return null if the text is valid
  //   return null;
  // }
  void _submit() {
    // validate all the form fields
    if (formKey.currentState!.validate()) {
      // on success, notify the parent widget
      widget.onSubmit(_userNameTextController.text);
    }
  }
}



// // then, in the build method:
// TextField(
//   controller: _controller,
//   decoration: InputDecoration(
//     labelText: 'Enter your name',
//     // use the getter variable defined above
//     errorText: _errorText,
//   ),
// ),