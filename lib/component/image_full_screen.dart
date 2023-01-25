import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sporent/component/firebase_image.dart';

class FullScreen extends StatelessWidget {
  const FullScreen(this.choice,
      {super.key, this.url, this.image, this.firebaseImage, this.filePath});

  final String? url;
  final File? image;
  final String? firebaseImage;
  final String? choice;
  final String? filePath;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned(
                top: size.height / 10,
                right: size.width / 50,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop(context);
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.xmark,
                      color: Colors.white,
                    ))),
            Center(
              child: Hero(
                  tag: 'imageHero',
                  child: SizedBox(
                      height: size.height / 1.5,
                      child: choice == "url"
                          ? Image.network(url!)
                          : choice == "file"
                              ? Image.file(image!)
                              : FirebaseImage(filePath: "$filePath/$firebaseImage"))),
            ),
          ],
        ));
  }
}
