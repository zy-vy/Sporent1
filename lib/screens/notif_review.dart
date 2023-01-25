import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sporent/component/firebase_image.dart';
import 'package:sporent/component/loading.dart';
import 'package:sporent/repository/image_repository.dart';
import 'package:sporent/reusable_widgets/reusable_widget.dart';
import 'package:sporent/screens/bottom_bar.dart';
import 'package:sporent/screens/home_screen.dart';
import 'package:sporent/screens/signup_final.dart';
import 'package:sporent/screens/transaction_screen.dart';

import '../utils/colors.dart';

class NotifReview extends StatefulWidget {
  const NotifReview({super.key});

  @override
  State<NotifReview> createState() => _NotifReview();
}

class _NotifReview extends State<NotifReview> {

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(top: _size.height / 80),
          child: const Text(
            "Review Success",
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
            CachedNetworkImage(imageUrl: "https://firebasestorage.googleapis.com/v0/b/sporent-80b28.appspot.com/o/notification%2FNotificationSuccess.png?alt=media&token=cb0223bf-0884-45a6-9f2e-39c72ab5cd42", placeholder: (context, url) => const CircularProgressIndicator(),),
            RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                    text: "Thank You For Your Review\n",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1),
                    children: [
                      TextSpan(
                        text: "Your review means a lot to the owner\n",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          height: 2,
                        ),
                      ),
                      TextSpan(
                        text:
                            "Your review can be seen in the product that you given your review",
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey, height: 1.5),
                      )
                    ])),
             SizedBox(height: _size.height / 30),
             SizedBox(
              width: _size.width,
              height: _size.height / 12,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: hexStringToColor("4164DE")),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const BottomBarScreen(
                              indexPage: "1",
                            )));
                  },
                  child: const Text("Back to Home",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18))),
            ),
          ],
        ),
      ),
    );
  }
}
