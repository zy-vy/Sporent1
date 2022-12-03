import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sporent/screens/color.dart';
import 'package:sporent/screens/deposit-detail.dart';

class DepositInformation extends StatefulWidget {
  const DepositInformation({super.key});

  @override
  State<DepositInformation> createState() => _DepositInformationState();
}

class _DepositInformationState extends State<DepositInformation> {
  TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Deposit Information"),
          ),
          backgroundColor: hexStringToColor("4164DE"),
        ),
        body: Padding(
            padding: EdgeInsets.only(top: _size.height/30),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: _size.height/30),
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: HexColor("CCCCCC")))),
                      child: SizedBox(
                        height: _size.height/4.5,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: _size.width/20),
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const DepositDetail(),
                                  ),
                                );
                              },
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "asset/images/tennis-racket.png",
                                      width: _size.width/3,
                                      height: _size.height/5.8,
                                    ),
                                    SizedBox(width: _size.width/15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "30 August 2022",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                        ),
                                        SizedBox(height: _size.height/90),
                                        const Text(
                                          "Raket Tenis",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        SizedBox(height: _size.height/90),
                                        Text(
                                          "Status: In Progress",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: HexColor("416DDE")),
                                        ),
                                        SizedBox(height: _size.height/95),
                                        Text(
                                          "Total Deposit:",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: HexColor("999999")),
                                        ),
                                        SizedBox(height: _size.height/98),
                                        const Text(
                                          "Rp 1.500.000",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )
                                      ],
                                    )
                                  ])),
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: _size.height/30),
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: HexColor("CCCCCC")))),
                      child: SizedBox(
                        height: _size.height/4.5,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: _size.width/20),
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const DepositDetail(),
                                  ),
                                );
                              },
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "asset/images/tennis-racket.png",
                                      width: _size.width/3,
                                      height: _size.height/5.8,
                                    ),
                                    SizedBox(width: _size.width/15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "30 August 2022",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                        ),
                                        SizedBox(height: _size.height/90),
                                        const Text(
                                          "Raket Tenis",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        SizedBox(height: _size.height/90),
                                        Text(
                                          "Status: In Progress",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: HexColor("416DDE")),
                                        ),
                                        SizedBox(height: _size.height/95),
                                        Text(
                                          "Total Deposit:",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: HexColor("999999")),
                                        ),
                                        SizedBox(height: _size.height/98),
                                        const Text(
                                          "Rp 1.500.000",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )
                                      ],
                                    )
                                  ])),
                        ),
                      )),
                ),
              ],
            )));
  }
}
