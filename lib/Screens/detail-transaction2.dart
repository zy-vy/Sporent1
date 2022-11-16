import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import '/firebase_options.dart';
import 'package:skripsi_sporent/Screens/color.dart';

class DetailTransaction2 extends StatefulWidget {
  const DetailTransaction2({super.key});

  @override
  State<DetailTransaction2> createState() => _DetailTransaction2State();
}

class _DetailTransaction2State extends State<DetailTransaction2> {
  File? image;

  Future openGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(imagePicked!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
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
        padding:
            const EdgeInsets.only(top: 30, left: 20, right: 35, bottom: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Product Photo",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Container(
              width: 80,
              height: 85,
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(width: 2, color: HexColor("868686")))),
              child: TextButton(
                  onPressed: () async {
                    await openGallery();
                  },
                  child: FaIcon(
                    FontAwesomeIcons.plus,
                    color: HexColor("4164DE"),
                    size: 35,
                  )),
            ),
            const SizedBox(height: 40),
            const Text("Live Tracking Gojek",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 70),
            Center(
              child: SizedBox(
                height: 70,
                width: 350,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor("4164DE"),
                    ),
                    child: const Text("Complete Order",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
