import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import '/firebase_options.dart';


class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPage();
}

class _CartPage extends State<CartPage> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            "Cart",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: _size.height/30, horizontal: _size.width/18),
        child: Column(
          children: [
            Expanded(
              child:  ListView(
              children: [
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'images/tennis-racket.png',
                          height: 130,
                          width: 130,
                        ),
                        SizedBox(width: _size.width/70),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Raket Tenis",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.normal)),
                            SizedBox(width: _size.width/90),
                            const Text("Rp 150.000/Day",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(width: _size.width/90),
                            Text("How many day",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: HexColor("969696"))),
                            SizedBox(width: _size.width/90),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: HexColor("416DDE"),
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (counter > 0) {
                                            counter--;
                                          }
                                        });
                                      },
                                      icon: const FaIcon(
                                        FontAwesomeIcons.minus,
                                        color: Colors.white,
                                        size: 20,
                                      )),
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  "$counter",
                                  style: const TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 15),
                                CircleAvatar(
                                  backgroundColor: HexColor("416DDE"),
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          counter++;
                                        });
                                      },
                                      icon: const FaIcon(
                                        FontAwesomeIcons.plus,
                                        color: Colors.white,
                                        size: 20,
                                      )),
                                ),
                                const SizedBox(width: 10),
                                IconButton(
                                    onPressed: () {},
                                    icon: FaIcon(
                                      FontAwesomeIcons.trash,
                                      color: HexColor("808080"),
                                    ))
                              ],
                            )
                          ],
                        )
                      ],
                    ),
              ],
            ),),
            Divider(thickness: 1, color: HexColor("A3A3A3")),
            const SizedBox(height: 15),
            Row(
              children: const [
                Expanded(
                  child: Text("Total: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
                Text("Rp 300.000", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
              ],
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: _size.width,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor("4164DE")
                ),
                onPressed: (){}, 
                child: const Text("Checkout", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
            )
          ],
        ),
      ),
    );
  }
}