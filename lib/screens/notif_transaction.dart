import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sporent/reusable_widgets/reusable_widget.dart';
import 'package:sporent/screens/signup_final.dart';
import 'package:sporent/screens/transaction_screen.dart';

import '../utils/colors.dart';

class NotifTransaction extends StatefulWidget {
  const NotifTransaction({super.key});

  @override
  State<NotifTransaction> createState() => _NotifTransaction();
}

class _NotifTransaction extends State<NotifTransaction> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(top: _size.height / 80),
          child: const Text(
            "Transaction Finish",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: _size.height / 10, horizontal: _size.width / 13),
        child: Column(
          children: [
            const Image(image: AssetImage("assets/images/fornotif.png")),
            SizedBox(height: _size.height / 100),
            RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                    text: "Your Transaction has Finished\n",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1),
                    children: [
                      TextSpan(
                        text: "Your product will be delivered to renter\n",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          height: 1.5,
                        ),
                      ),
                      TextSpan(
                        text:
                            "For your deposit, it will appear on deposit information on profile page, based on product you return",
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey, height: 1.5),
                      )
                    ])),
            SizedBox(height: _size.height / 45),
            SizedBox(
              width: _size.width,
              height: 53,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: hexStringToColor("4164DE")),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const TransactionScreen()));
                  },
                  child: const Text("Give Review",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18))),
            ),
            const SizedBox(height: 20),
            SizedBox(
              child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignUpScreenFinal()));
                  },
                  child: const Text("Back to Home",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blue))),
            )
          ],
        ),
      ),
    );
  }
}
