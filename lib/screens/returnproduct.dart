import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sporent/utils/colors.dart';

class ReturnProduct extends StatefulWidget {
  const ReturnProduct(this.idOwner, this.idTracking, {super.key});
  final String idOwner;
  final String idTracking;

  @override
  State<ReturnProduct> createState() => _ReturnProductState();
}

class _ReturnProductState extends State<ReturnProduct> {
  final photoController = TextEditingController();
  final trackingController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  File? image;
  bool enabled = false;
  bool haveData = false;
  DocumentReference<Map<String, dynamic>>? referenceCategory;

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
            child: const Text("Return Product"),
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
                      Container(
                        width: _size.width / 5,
                        height: _size.height / 10,
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                    width: 2,
                                    color: hexStringToColor("868686")))),
                        child: TextButton(
                          onPressed: () async {
                            await openGallery();
                          },
                          child: image != null
                              ? Image.file(image!)
                              : FaIcon(
                                  FontAwesomeIcons.plus,
                                  color: hexStringToColor("4164DE"),
                                  size: 35,
                                ),
                        ),
                      ),
                      SizedBox(height: _size.height / 23),
                      StreamBuilder(
                        stream: firestore
                            .collection("user")
                            .doc(widget.idOwner)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Delivery Information",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(height: _size.height / 50),
                                Text(snapshot.data!.get("address")),
                                SizedBox(height: _size.height / 23),
                              ],
                            );
                          }
                        },
                      ),
                      // fieldText(
                      //     "Live Tracking Online Driver Link",
                      //     "Enter your online driver link",
                      //     _size,
                      //     trackingController),
                      SizedBox(height: _size.height / 50),
                      const Text("Live Tracking Online Driver Link",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      SizedBox(height: _size.height / 50),
                      TextFormField(
                        controller: trackingController,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 5,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Enter your online driver link"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Tracking Link must be Filled";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: _size.height / 50),
                      SizedBox(
                          width: _size.width,
                          height: _size.height / 15,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                FirebaseFirestore.instance
                                    .collection("transaction")
                                    .doc(widget.idTracking)
                                    .update({
                                  "tracking_code": trackingController.text
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: hexStringToColor("4164DE"),
                              // padding: const EdgeInsets.only(right: 300, bottom: 40)
                            ),
                            child: const Text("Return Product",
                                textAlign: TextAlign.center),
                          )),
                    ],
                  ),
                ),
              ],
            )));
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
