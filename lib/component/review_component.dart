import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/image_full_screen.dart';
import 'package:sporent/component/item_title.dart';

import '../model/review.dart';

class ReviewComponent extends StatefulWidget {
  const ReviewComponent(this.review, this.haveLine, {super.key});

  final Review review;
  final bool haveLine;

  @override
  State<ReviewComponent> createState() => _ReviewComponentState();
}

class _ReviewComponentState extends State<ReviewComponent> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  File? temp;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder(
        stream: firestore
            .collection("user")
            .doc(widget.review.user!.id.toString())
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var name = snapshot.data!.get("name");
            var image = snapshot.data!.get("image");

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.haveLine == true
                    ? Padding(
                        padding: EdgeInsets.only(bottom: size.height / 80),
                        child: Divider(color: HexColor("E6E6E6"), thickness: 3),
                      )
                    : const SizedBox(),
                Row(
                  children: [
                    GestureDetector(
                      child: ClipOval(
                          child: CachedNetworkImage(
                        height: size.height / 22,
                        width: size.width / 10,
                        imageUrl: image,
                        fit: BoxFit.fill,
                      )),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FullScreen("url", url: image),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: size.width / 30),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(right: size.width / 80),
                                child: FaIcon(
                                  FontAwesomeIcons.solidStar,
                                  color: HexColor("ED8A19"),
                                  size: 15,
                                )),
                            SizedBox(height: size.height / 45),
                            Text(widget.review.star.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: size.width / 35),
                  child: Text(widget.review.detail.toString(), textAlign: TextAlign.justify ,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal), maxLines: 5)
                ),
                Row(
                  children: [
                    for (var i = 0; i < widget.review.photo!.length; i++)
                      i == 0
                          ? GestureDetector(
                              child: Container(
                                decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                            width: 2,
                                            color: HexColor("4164DE")))),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.review.photo![i],
                                      fit: BoxFit.fill,
                                      width: size.width / 5,
                                      height: size.height / 10,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                    )),
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => FullScreen("url",
                                          url: widget.review.photo![i])),
                                );
                              },
                            )
                          : GestureDetector(
                              child: Container(
                                margin: EdgeInsets.only(left: size.width / 20),
                                decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                            width: 2,
                                            color: HexColor("4164DE")))),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.review.photo![i],
                                      fit: BoxFit.fill,
                                      width: size.width / 5,
                                      height: size.height / 10,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                    )),
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => FullScreen(
                                      "url",
                                      url: widget.review.photo![i],
                                    ),
                                  ),
                                );
                              },
                            )
                  ],
                ),
              ],
            );
          }
        });
  }
}
