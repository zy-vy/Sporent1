import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sporent/screens/bottom_bar.dart';
import 'package:sporent/screens/transaction_screen.dart';

import '../utils/colors.dart';

class NotifComplain extends StatefulWidget {
  const NotifComplain({super.key});

  @override
  State<NotifComplain> createState() => _NotifComplain();
}

class _NotifComplain extends State<NotifComplain> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(top: _size.height / 80),
          child: const Text(
            "Complain Finish",
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
            SizedBox(height: _size.height / 100),
            RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                    text: "Your Complain has been received\n",
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1),
                    children: [
                      TextSpan(
                        text: "Your complain will be sent to admin\n",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          height: 1.5,
                        ),
                      ),
                      TextSpan(
                        text:
                            "Sorry for your inconvenience, your complain will be reviewed soon and your complain progress can be seen in manage complain page",
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey, height: 1.5),
                      )
                    ])),
            SizedBox(height: _size.height / 45),
            SizedBox(
              width: _size.width,
              height: 53,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: hexStringToColor("4164DE")),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const BottomBarScreen(indexPage: "1",)));
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
