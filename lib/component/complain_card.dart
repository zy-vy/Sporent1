import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/firebase_image.dart';
import 'package:sporent/component/image_full_screen.dart';

class ComplainCard extends StatelessWidget {
  const ComplainCard(this.image, this.description, this.date, this.haveLine,
      {super.key});

  final List<dynamic> image;
  final String description;
  final String date;
  final bool haveLine;

  @override
  Widget build(BuildContext context) {
    File? temp;
    Size _size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: _size.height / 40),
        haveLine == true
            ? Padding(
                padding: EdgeInsets.only(bottom: _size.height / 80),
                child: Divider(color: HexColor("E6E6E6"), thickness: 3),
              )
            : const SizedBox(),
        Text("Date: $date"),
        SizedBox(height: _size.height / 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < image.length; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Container(
                      width: _size.width / 5,
                      height: _size.height / 10,
                      decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                  width: 2, color: HexColor("4164DE"))),
                          image: DecorationImage(
                              image: NetworkImage(image[i]), fit: BoxFit.fill)),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FullScreen("url",url: image[i]),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: _size.width / 30)
                ],
              ),
          ],
        ),
        SizedBox(height: _size.height / 40),
        Text(description, style: const TextStyle(fontWeight: FontWeight.w500))
      ],
    );
  }
}
