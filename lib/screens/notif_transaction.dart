import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/screens/bottom_bar.dart';
import 'package:sporent/screens/give_review.dart';

import '../utils/colors.dart';

class NotifTransaction extends StatelessWidget {
  const NotifTransaction(this.product_name, this.product_image, this.total, this.idProduct, this.idUser, {super.key});

  final String product_name;
  final String product_image;
  final int total;
  final String idProduct;
  final String idUser;

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
            vertical: _size.height / 13, horizontal: _size.width / 13),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl:
                  "https://firebasestorage.googleapis.com/v0/b/sporent-80b28.appspot.com/o/notification%2FNotificationSuccess.png?alt=media&token=cb0223bf-0884-45a6-9f2e-39c72ab5cd42",
              placeholder: (context, url) => const CircularProgressIndicator(),
            ),
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
                          height: 2,
                        ),
                      ),
                      TextSpan(
                        text:
                            "For your deposit, it will appear on deposit information on profile page, based on product you return",
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey, height: 1.8),
                      )
                    ])),
            SizedBox(height: _size.height / 45),
            SizedBox(
              width: _size.width,
              height: _size.height/15,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: hexStringToColor("4164DE")),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GiveReview(product_name,
                            product_image, total, idProduct, idUser)));
                  },
                  child: const Text("Give Review",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18))),
            ),
            const SizedBox(height: 20),
            SizedBox(
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const BottomBarScreen(
                              indexPage: "0",
                            )));
                  },
                  child: Text("Back to Home",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: HexColor("4164DE")))),
            )
          ],
        ),
      ),
    );
  }
}
