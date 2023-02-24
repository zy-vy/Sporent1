import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sporent/screens/notif_review.dart';

import '../component/loading.dart';
import '../component/transaction_card_detail.dart';
import '../model/review.dart';

class GiveReview extends StatefulWidget {
  const GiveReview(this.product_name, this.product_image, this.total,
      this.idProduct, this.idUser,
      {super.key});

  final String product_name;
  final String product_image;
  final int total;
  final String idProduct;
  final String idUser;

  @override
  State<GiveReview> createState() => _GiveReviewState();
}

class _GiveReviewState extends State<GiveReview> {
  final TextEditingController controller = TextEditingController();
  bool changeColor1 = true;
  bool changeColor2 = true;
  bool changeColor3 = true;
  bool changeColor4 = true;
  bool changeColor5 = true;
  int counter = 5;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool enabled = false;
  bool haveData = false;
  bool loading = false;
  bool haveImage = false;
  File? image;
  File? imageTemp;
  List<File?> listImages = [];
  String? productCategory;
  int counterImage = 1;
  List<String> _arrImageUrls = [];

  FirebaseStorage _storage = FirebaseStorage.instance;

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
    Size _size = MediaQuery.of(context).size;

    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: Transform(
                transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
                child: const Text("Give Review"),
              ),
              backgroundColor: HexColor("4164DE"),
            ),
            resizeToAvoidBottomInset: false,
            body: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: _size.height / 30,
                      horizontal: _size.width / 18),
                  child: Column(
                    children: [
                      DetailTransactionCard(
                          18,
                          16,
                          15,
                          18,
                          "Total Payment",
                          widget.product_image,
                          widget.product_name,
                          widget.total),
                      SizedBox(height: _size.height / 50),
                      Row(
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(0)),
                            onPressed: () {
                              setState(() {
                                if (changeColor1 == false) {
                                  changeColor1 = true;
                                  counter = 1;
                                } else {
                                  changeColor2 = false;
                                  changeColor3 = false;
                                  changeColor4 = false;
                                  changeColor5 = false;
                                  counter = 1;
                                }
                              });
                            },
                            child: FaIcon(FontAwesomeIcons.solidStar,
                                color: changeColor1 == false
                                    ? HexColor("ABABAB")
                                    : HexColor("ED8A19"),
                                size: 50),
                          ),
                          SizedBox(width: _size.width / 60),
                          TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(0)),
                            onPressed: () {
                              setState(() {
                                if (changeColor2 == false) {
                                  changeColor1 = true;
                                  changeColor2 = true;
                                  counter = 2;
                                } else {
                                  changeColor3 = false;
                                  changeColor4 = false;
                                  changeColor5 = false;
                                  counter = 2;
                                }
                              });
                            },
                            child: FaIcon(FontAwesomeIcons.solidStar,
                                color: changeColor2 == false
                                    ? HexColor("ABABAB")
                                    : HexColor("ED8A19"),
                                size: 50),
                          ),
                          SizedBox(width: _size.width / 60),
                          TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(0)),
                            onPressed: () {
                              setState(() {
                                if (changeColor3 == false) {
                                  changeColor1 = true;
                                  changeColor2 = true;
                                  changeColor3 = true;
                                  counter = 3;
                                } else {
                                  changeColor4 = false;
                                  changeColor5 = false;
                                  counter = 3;
                                }
                              });
                            },
                            child: FaIcon(FontAwesomeIcons.solidStar,
                                color: changeColor3 == false
                                    ? HexColor("ABABAB")
                                    : HexColor("ED8A19"),
                                size: 50),
                          ),
                          SizedBox(width: _size.width / 60),
                          TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(0)),
                            onPressed: () {
                              setState(() {
                                if (changeColor4 == false) {
                                  changeColor1 = true;
                                  changeColor2 = true;
                                  changeColor3 = true;
                                  changeColor4 = true;
                                  counter = 4;
                                } else {
                                  changeColor5 = false;
                                  counter = 4;
                                }
                              });
                            },
                            child: FaIcon(FontAwesomeIcons.solidStar,
                                color: changeColor4 == false
                                    ? HexColor("ABABAB")
                                    : HexColor("ED8A19"),
                                size: 50),
                          ),
                          SizedBox(width: _size.width / 60),
                          TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(0)),
                            onPressed: () {
                              setState(() {
                                if (changeColor5 == false) {
                                  changeColor1 = true;
                                  changeColor2 = true;
                                  changeColor3 = true;
                                  changeColor4 = true;
                                  changeColor5 = true;
                                  counter = 5;
                                }
                              });
                            },
                            child: FaIcon(FontAwesomeIcons.solidStar,
                                color: changeColor5 == false
                                    ? HexColor("ABABAB")
                                    : HexColor("ED8A19"),
                                size: 50),
                          ),
                          SizedBox(width: _size.width / 60)
                        ],
                      ),
                      SizedBox(height: _size.height / 25),
                      TextFormField(
                        textAlign: TextAlign.justify,
                        controller: controller,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 20,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: _size.height / 40,
                                horizontal: _size.width / 15),
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: HexColor("979797")),
                            hintText:
                                "Give your review of what products need to be improved and are not satisfied with the product",
                            border: const OutlineInputBorder()),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Description must not be empty";
                          }
                          if (value.length < 20) {
                            return "Description must more than 20 characters";
                          }
                        },
                      ),
                      SizedBox(height: _size.height / 30),
                      counterImage == 1
                          ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton(
                                  onPressed: () async {
                                    await openGallery();
                                    setState(() {
                                      if (counterImage >= 2) {
                                        listImages.remove(imageTemp);
                                      }

                                      listImages.add(image);

                                      if (counterImage != 3) {
                                        listImages.add(imageTemp);
                                        counterImage += 1;
                                      }
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          vertical: _size.height / 40,
                                          horizontal: _size.width / 15),
                                      side: BorderSide(
                                          color: haveImage ? HexColor("C2413C") : HexColor("868686"), width: 1)),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.camera,
                                        color: HexColor("979797"),
                                        size: 30,
                                      ),
                                      SizedBox(width: _size.width / 40),
                                      Text(
                                        "Add Photo",
                                        style: TextStyle(
                                            color: HexColor("979797"),
                                            fontSize: 14),
                                      )
                                    ],
                                  )),
                                  haveImage == true
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: _size.height / 80),
                                
                                Row(
                                  children: [
                                    SizedBox(width: _size.width / 15,),
                                    Text(
                                      "Image must not be empty",
                                      style: TextStyle(
                                          color: HexColor("C2413C"), fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : const SizedBox(),
                            ],
                          )
                          : Row(
                              children: [
                                for (int i = 0; i < counterImage; i++)
                                  Row(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            width: _size.width / 5,
                                            height: _size.height / 10,
                                            decoration: ShapeDecoration(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    side: BorderSide(
                                                        width: 2,
                                                        color: HexColor(
                                                            "868686")))),
                                            child: TextButton(
                                                onPressed: () async {
                                                  await openGallery();
                                                  setState(() {
                                                    if (counterImage >= 2) {
                                                      listImages
                                                          .remove(imageTemp);
                                                    }

                                                    listImages.add(image);

                                                    if (counterImage != 3) {
                                                      listImages.add(imageTemp);
                                                      counterImage += 1;
                                                    }
                                                  });
                                                },
                                                child: listImages.isEmpty ==
                                                        true
                                                    ? FaIcon(
                                                        FontAwesomeIcons.plus,
                                                        color:
                                                            HexColor("4164DE"),
                                                        size: 35,
                                                      )
                                                    : listImages[i] != null
                                                        ? Image.file(
                                                            listImages[i]!)
                                                        : FaIcon(
                                                            FontAwesomeIcons
                                                                .plus,
                                                            color: HexColor(
                                                                "4164DE"),
                                                            size: 35,
                                                          )),
                                          ),
                                          listImages.isEmpty == true
                                              ? const Positioned(
                                                  right: 0,
                                                  top: 0,
                                                  child: SizedBox())
                                              : listImages[i] != null
                                                  ? Positioned(
                                                      right: 0,
                                                      child: Container(
                                                          height: 25,
                                                          width: 25,
                                                          decoration:
                                                              const BoxDecoration(
                                                                  color: Colors
                                                                      .blueAccent,
                                                                  shape: BoxShape
                                                                      .circle),
                                                          child: IconButton(
                                                            icon: const FaIcon(
                                                                FontAwesomeIcons
                                                                    .xmark,
                                                                size: 10,
                                                                color: Colors
                                                                    .white),
                                                            onPressed: () {
                                                              setState(() {
                                                                listImages.remove(
                                                                    listImages[
                                                                        i]);
                                                                if (counterImage !=
                                                                    1) {
                                                                  counterImage -=
                                                                      1;
                                                                }
                                                              });
                                                            },
                                                          )),
                                                    )
                                                  : const Positioned(
                                                      right: 0,
                                                      top: 0,
                                                      child: SizedBox())
                                        ],
                                      ),
                                      counterImage != 1
                                          ? SizedBox(width: _size.width / 20)
                                          : const SizedBox(),
                                    ],
                                  ),
                              ],
                            ),
                      SizedBox(height: _size.height / 20),
                      SizedBox(
                          width: _size.width,
                          height: _size.height / 12,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (image == null) {
                                setState(() {
                                  haveImage = true;
                                });
                              }

                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });

                                List<String> listNameImage = [];
                                var reviewRef =
                                    firestore.collection("review").doc();

                                for (int i = 0; i < listImages.length-1; i++) {
                                  int counterTempImage = i + 1;

                                  final ref = FirebaseStorage.instance
                                      .ref()
                                      .child('review-images/')
                                      .child(
                                          "${reviewRef.id}_$counterTempImage.jpg");

                                  await ref.putFile(listImages[i]!);

                                  String imageName = await ref.getDownloadURL();
                                  listNameImage.add(imageName);
                                }

                                var review = Review(
                                        detail: controller.text,
                                        star: counter,
                                        photo: listNameImage,
                                        product: firestore
                                            .collection("product")
                                            .doc(widget.idProduct),
                                        user: firestore
                                            .collection("user")
                                            .doc(widget.idUser))
                                    .toJson();

                                await reviewRef.set(review);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const NotifReview()));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: HexColor("4164DE"),
                            ),
                            child: const Text("Give Review",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                                textAlign: TextAlign.center),
                          )),
                    ],
                  ),
                )));
  }
}
