import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:skripsi_sporent/Screens/color.dart';
import 'package:skripsi_sporent/screens/deposit-detail.dart';

class DepositInformation extends StatefulWidget {
  const DepositInformation({super.key});

  @override
  State<DepositInformation> createState() => _DepositInformationState();
}

class _DepositInformationState extends State<DepositInformation> {
  TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.only(top: 30, bottom: 35),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: HexColor("CCCCCC")))),
                      child: SizedBox(
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 35,
                          ),
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
                                      "images/tennis-racket.png",
                                      width: 150,
                                      height: 150,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
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
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Raket Tenis",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Status: In Progress",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: HexColor("416DDE")),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          "Total Deposit:",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: HexColor("999999")),
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        ),
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
                  padding: const EdgeInsets.only(bottom: 30),
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: HexColor("CCCCCC")))),
                      child: SizedBox(
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 35),
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
                                      "images/tennis-racket.png",
                                      width: 150,
                                      height: 150,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
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
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Raket Tenis",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Status: In Progress",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: HexColor("416DDE")),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          "Total Deposit:",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: HexColor("999999")),
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        ),
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
                )
              ],
            )));
  }
}
