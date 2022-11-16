import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:skripsi_sporent/screens/add-product-renter.dart';
import 'package:skripsi_sporent/screens/detail-transaction1.dart';
import '/firebase_options.dart';
import 'package:skripsi_sporent/Screens/color.dart';

class ManageTransaction extends StatelessWidget {
  const ManageTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
          child: const Text("Manage Transaction"),
        ),
        backgroundColor: hexStringToColor("4164DE"),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 30, left: 20, right: 35, bottom: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(color: HexColor("F5F5F5")),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, top: 15, bottom: 15, right: 10),
                  child: Row(
                    children: [
                      Image.asset(
                        "images/tennis-racket.png",
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Raket Tenis",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                          const SizedBox(height: 10),
                          const Text("Rp 150.000/Day",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          const Text("Time: 2 Day",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black)),
                          const SizedBox(height: 10),
                          Text("Status: New",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: HexColor("416DDE"),
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 80,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) =>
                                    const DetailTransaction1()
                                )
                              )
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: HexColor("4164DE")),
                          child: const Text("Detail",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
