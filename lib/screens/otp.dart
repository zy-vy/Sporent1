import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sporent/reusable_widgets/reusable_widget.dart';
import 'package:sporent/screens/bottom_bar.dart';
import 'package:sporent/screens/homepage.dart';
import 'package:sporent/screens/signup_final.dart';
import 'package:sporent/screens/signup_screen.dart';
import 'package:sporent/utils/colors.dart';

class OTP extends StatefulWidget {
  const OTP(this.phoneNumber1, {super.key});
  final String phoneNumber1;

  @override
  State<OTP> createState() => _OTP();
}

final FirebaseAuth auth = FirebaseAuth.instance;

TextEditingController _OTPController1 = TextEditingController();
TextEditingController _OTPController2 = TextEditingController();
TextEditingController _OTPController3 = TextEditingController();
TextEditingController _OTPController4 = TextEditingController();
TextEditingController _OTPController5 = TextEditingController();
TextEditingController _OTPController6 = TextEditingController();

class _OTP extends State<OTP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: hexStringToColor("4164DE")),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height * 0.15, 20, 0),
                child: Column(children: <Widget>[
                  logoWidget("assets/images/logo.png"),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Verification",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Enter the Verification Number",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _textFieldOTP(
                          first: true,
                          last: false,
                          controller: _OTPController1),
                      _textFieldOTP(
                          first: false,
                          last: false,
                          controller: _OTPController2),
                      _textFieldOTP(
                          first: false,
                          last: false,
                          controller: _OTPController3),
                      _textFieldOTP(
                          first: false,
                          last: false,
                          controller: _OTPController4),
                      _textFieldOTP(
                          first: false,
                          last: false,
                          controller: _OTPController5),
                      _textFieldOTP(
                          first: false,
                          last: true,
                          controller: _OTPController6),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: ElevatedButton(
                      onPressed: () async {
                        String FinalOTP = _OTPController1.text.toString() +
                            _OTPController2.text.toString() +
                            _OTPController3.text.toString() +
                            _OTPController4.text.toString() +
                            _OTPController5.text.toString() +
                            _OTPController6.text.toString();
                        print(FinalOTP);
                        try {
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                                  verificationId: SignUpScreenFinal.verify,
                                  smsCode: FinalOTP);
                          await auth.signInWithCredential(credential);
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BottomBarScreen(indexPage: "0",)));
                        } catch (e) {
                          print("wrong otp");
                        }
                      },
                      child: const Text(
                        'VERIFY',
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  ResendOption(widget.phoneNumber1)
                ]),
              ),
            )));
  }

  _textFieldOTP(
      {required bool first, last, required TextEditingController controller}) {
    return Container(
      height: 85,
      child: AspectRatio(
        aspectRatio: 0.7,
        child: TextField(
          controller: controller,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black12),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.purple),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  Row ResendOption(String phoneNumber1) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("Didn't receive the verification code ? ",
          style: TextStyle(color: Colors.white70)),
      GestureDetector(
        onTap: () {
          phoneAuthentication(phoneNumber1);
        },
        child: const Text(
          "Resend New Code",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      )
    ]);
  }

  void phoneAuthentication(String phoneNumber1) async {
    if (phoneNumber1[0] == "0") {
      phoneNumber1 = phoneNumber1.replaceFirst(RegExp(r'0'), '+62');
    }
    if (phoneNumber1[0] == "6" && phoneNumber1[1] == "2") {
      phoneNumber1 = phoneNumber1.replaceFirst(RegExp(r'62'), '+62');
    } else {
      phoneNumber1 = phoneNumber1;
    }
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber1,
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        SignUpScreenFinal.verify = verificationId;
        Navigator.pushNamed(context, "otp");
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
