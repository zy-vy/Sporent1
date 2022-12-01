import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/screens/add-product-renter.dart';
import 'package:sporent/screens/detail-transaction1.dart';
import '/firebase_options.dart';
import 'package:sporent/screens/color.dart';

class ManageTransaction extends StatelessWidget {
  const ManageTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

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
            EdgeInsets.symmetric(vertical: _size.height/30, horizontal: _size.width/18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(color: HexColor("F5F5F5")),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: _size.height/30, horizontal: _size.width/25),
                  child: Row(
                    children: [
                      Image.asset(
                        "images/tennis-racket.png",
                        width: _size.width/4,
                        height: _size.height/8,
                      ),
                      SizedBox(width: _size.width/30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Raket Tenis",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                          SizedBox(height: _size.height/90),
                          const Text("Rp 150.000/Day",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: _size.height/90),
                          const Text("Time: 2 Day",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black)),
                          SizedBox(height: _size.height/90),
                          Text("Status: New",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: HexColor("416DDE"),
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(width: _size.width/25),
                      SizedBox(
                        width: _size.width/5,
                        height: _size.height/15,
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
