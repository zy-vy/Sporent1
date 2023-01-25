import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sporent/component/firebase_image.dart';

class FullScreen extends StatelessWidget {
  const FullScreen(this.url, this.image, {super.key,this.location});

  final String? url;
  final String? image;
  final String? location;

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
                      height: size.height / 1.5, child: url != "" ? Image.network(url!) : location !=null ? FirebaseImage(filePath: "$location/$image") :FirebaseImage(filePath: "condition-check/$image"))),
            ),
          ],
        ));
  }
}
