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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Padding(
                padding: EdgeInsets.only(left: _size.width/20, bottom: _size.height/80),
                child: const Text(
                  "Status: In Progress",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Divider(
                thickness: 2,
                color: HexColor("E0E0E0"),
              ),
              Padding(
                  padding: EdgeInsets.only(top: _size.height/70, left: _size.width/20, bottom: _size.height/60),
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
                        SizedBox(height: _size.height/50),
                        Row(
                          children: [
                            Image.asset(
                              "images/tennis-racket.png",
                              width: _size.width/3,
                              height: _size.height/5.8,
                            ),
                            SizedBox(width: _size.width/15),
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
                                SizedBox(height: _size.height/80),
                                const Text(
                                  "Time: 2 hour",
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(height: _size.height/60),
                                Text(
                                  "Total Deposit:",
                                  style: TextStyle(
                                      fontSize: 18, color: HexColor("999999")),
                                ),
                                SizedBox(height: _size.height/95),
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
              Padding(
                padding: EdgeInsets.only(top: _size.height/50, left: _size.width/20, bottom: _size.height/60),
                child: const Text(
                  "Bank Information",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: _size.width/20, top: _size.height/90),
                child: Row(
                  children: [
                      const Text(
                      "Bank Name",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(width: _size.width/5),
                    const Text("BCA",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: _size.width/20, top: _size.height/50),
                child: Row(
                  children: [
                      const Text(
                      "Account Number",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(width: _size.width/10),
                    const Text("0211276484758",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
