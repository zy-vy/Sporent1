import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/screens/add-product-renter.dart';
import 'package:sporent/screens/detail-transaction2.dart';
import '/firebase_options.dart';
import 'package:sporent/screens/color.dart';

class DetailTransaction1 extends StatelessWidget {
  const DetailTransaction1({super.key});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
          child: const Text("Detail Transaction"),
        ),
        backgroundColor: hexStringToColor("4164DE"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: _size.height/40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _size.width/18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Booking Period",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: _size.height/40),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "30, August 2022,",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            "14:00",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      SizedBox(width: _size.width/10),
                      const FaIcon(FontAwesomeIcons.arrowRight),
                      SizedBox(width: _size.width/10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "30, August 2022,",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            "16:00",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: _size.height/70),
            Divider(color: hexStringToColor("E0E0E0"), thickness: 2),
            SizedBox(height: _size.height/40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _size.width/18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Detail Product",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: _size.height/40),
                  Row(
                    children: [
                      Image.asset(
                        "images/tennis-racket.png",
                        height: _size.height/6,
                        width: _size.width/3,
                      ),
                      SizedBox(width: _size.width/20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Raket Tenis",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: _size.height/80),
                          const Text(
                            "Time: 2 Hour",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.normal),
                          ),
                          SizedBox(height: _size.height/80),
                          Text(
                            "Total Payment",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: HexColor("A6A6A6")),
                          ),
                          SizedBox(height: _size.height/90),
                          const Text(
                            "Rp 300.000",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: _size.height/30),
            Divider(color: hexStringToColor("E0E0E0"), thickness: 2),
            SizedBox(height: _size.height/50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _size.width/18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Delivery Information",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: _size.height/40),
                  Row(
                    children: const [
                      Expanded(
                          child: Text(
                        "Delivery Type",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      )),
                      Expanded(
                          child: Text(
                        "Same - Day (1 - 2 Jam)",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ))
                    ],
                  ),
                  SizedBox(height: _size.height/40),
                  Row(
                    children: const [
                      Expanded(
                          child: Text(
                        "Recipient",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      )),
                      Expanded(
                          child: Text(
                        "Umar (628123456789)",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ))
                    ],
                  ),
                  SizedBox(height: _size.height/40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Expanded(
                          child: Text(
                        "Address",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      )),
                      Expanded(
                          child: Text(
                        "Jalan grogol pertamburan timur no 37 Kec. Taman Sari, Kota Jakarta Barat",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ))
                    ],
                  ),
                  SizedBox(height: _size.height/20),
                  Center(
                    child: SizedBox(
                      height: _size.height/12,
                      width: _size.width,
                      child: ElevatedButton(
                          onPressed: () {
                             Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) =>
                                    const DetailTransaction2()
                                )
                              )
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: HexColor("4164DE"),
                          ),
                          child: const Text("Confirm Order",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18))),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
