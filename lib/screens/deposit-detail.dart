import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sporent/screens/color.dart';

class DepositDetail extends StatefulWidget {
  const DepositDetail({super.key});

  @override
  State<DepositDetail> createState() => _DepositDetailState();
}

class _DepositDetailState extends State<DepositDetail> {
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20, bottom: 15),
                child: Text(
                  "Status: In Progress",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Divider(
                thickness: 2,
                color: HexColor("E0E0E0"),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, bottom: 30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Detail Product",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Image.asset(
                              "images/tennis-racket.png",
                              width: 150,
                              height: 150,
                            ),
                            const SizedBox(width: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Raket Tenis",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Time: 2 hour",
                                  style: TextStyle(fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "Total Deposit:",
                                  style: TextStyle(
                                      fontSize: 18, color: HexColor("999999")),
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
                          ],
                        ),
                      ])),
              Divider(thickness: 2, color: HexColor("E0E0E0")),
              const Padding(
                padding: EdgeInsets.only(left: 20, bottom: 15, top: 20),
                child: Text(
                  "Bank Information",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  children: const [
                      Text(
                      "Bank Name",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(width: 81),
                    Text("BCA",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Row(
                  children: const [
                      Text(
                      "Account Number",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(width: 40),
                    Text("0211276484758",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
