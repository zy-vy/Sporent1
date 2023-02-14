import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sporent/model/complain_detail.dart';
import 'package:sporent/screens/notif_complain.dart';
import 'package:sporent/utils/colors.dart';

class ComplainFeedback extends StatefulWidget {
  const ComplainFeedback(this.idComplain, {super.key});
  final String idComplain;

  @override
  State<ComplainFeedback> createState() => _ComplainFeedbackState();
}

class _ComplainFeedbackState extends State<ComplainFeedback> {
  final photoController = TextEditingController();
  final complainController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late DocumentReference imgRef;
  bool enabled = false;
  bool haveData = false;
  File? image;
  File? imageTemp;
  List<File?> listImages = [];
  String? productCategory;
  int counter = 1;
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

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Complain Feedback"),
          ),
          backgroundColor: hexStringToColor("4164DE"),
        ),
        resizeToAvoidBottomInset: true,
        body: Form(
            key: formKey,
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: _size.height / 30,
                      horizontal: _size.width / 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Please take a picture of your product",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: _size.height / 50),
                      Row(
                        children: [
                          for (int i = 0; i < counter; i++)
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
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                  width: 2,
                                                  color: hexStringToColor(
                                                      "868686")))),
                                      child: TextButton(
                                          onPressed: () async {
                                            await openGallery();
                                            setState(() {
                                              if (counter >= 1) {
                                                listImages.remove(imageTemp);
                                              }

                                              listImages.add(image);

                                              if (counter != 2) {
                                                listImages.add(imageTemp);
                                                counter += 1;
                                              }
                                            });
                                          },
                                          child: listImages.isEmpty == true
                                              ? FaIcon(
                                                  FontAwesomeIcons.plus,
                                                  color: hexStringToColor(
                                                      "4164DE"),
                                                  size: 35,
                                                )
                                              : listImages[i] != null
                                                  ? Image.file(listImages[i]!)
                                                  : FaIcon(
                                                      FontAwesomeIcons.plus,
                                                      color: hexStringToColor(
                                                          "4164DE"),
                                                      size: 35,
                                                    )),
                                    ),
                                    listImages.isEmpty == true
                                        ? const Positioned(
                                            right: 0, top: 0, child: SizedBox())
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
                                                          color: Colors.white),
                                                      onPressed: () {
                                                        setState(() {
                                                          listImages.remove(
                                                              listImages[i]);
                                                          if (counter != 1) {
                                                            counter -= 1;
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
                                counter != 1
                                    ? SizedBox(width: _size.width / 20)
                                    : const SizedBox(),
                              ],
                            ),
                        ],
                      ),
                      SizedBox(height: _size.height / 23),
                      const Text("Complain Feedback",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      SizedBox(height: _size.height / 50),
                      TextFormField(
                        controller: complainController,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 5,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Please describe your complain"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Complain must be Filled";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: _size.height / 20),
                      SizedBox(
                          width: _size.width,
                          height: _size.height / 12,
                          child: ElevatedButton(
                            onPressed: () {
                              uploadFile(listImages, widget.idComplain,
                                  complainController.text);

                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: hexStringToColor("4164DE"),
                            ),
                            child: const Text("Complain Product",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                                textAlign: TextAlign.center),
                          )),
                    ],
                  ),
                ),
              ],
            )));
  }
}

Future uploadFile(
    List<File?> listImages, String id, String complainController) async {
  final refcomplain = FirebaseFirestore.instance.collection('complain').doc(id);
  final refComplainDetail =
      FirebaseFirestore.instance.collection("complain_detail").doc();

  List<String> _arrImageUrls = [];

  if (listImages.isEmpty) {
    final complainDetail = ComplainDetail(
            date: DateTime.now(),
            description: complainController,
            complain: refcomplain)
        .toJSON();

    await FirebaseFirestore.instance
        .collection("complain_detail")
        .doc()
        .set(complainDetail);
  } else {
    for (int i = 0; i < listImages.length; i++) {
      if(listImages[i]!=null){
        Reference reference = FirebaseStorage.instance
            .ref()
            .child('complain-images/${refComplainDetail.id + i.toString()}');
        await reference.putFile(listImages[i]!);
        String urlImage = await reference.getDownloadURL();
        _arrImageUrls.add(urlImage);
      }
    }

    final complainDetail = ComplainDetail(
            date: DateTime.now(),
            description: complainController,
            image: _arrImageUrls,
            complain: refcomplain)
        .toJSON();

    await FirebaseFirestore.instance
        .collection("complain_detail")
        .doc()
        .set(complainDetail);
  }
}

Column fieldText(String title, String desc, Size _size,
        TextEditingController controller) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        SizedBox(height: _size.height / 50),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 5,
          decoration: InputDecoration(
              border: const OutlineInputBorder(), labelText: desc),
          validator: (value) {
            if (value!.isEmpty) {
              return "Tracking Link must be Filled";
            } else {
              return null;
            }
          },
        ),
        SizedBox(height: _size.height / 23),
      ],
    );
