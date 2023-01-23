import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sporent/screens/notif_complain.dart';
import 'package:sporent/utils/colors.dart';
import 'package:path/path.dart';

import '../model/complain.dart';

class ComplainProduct extends StatefulWidget {
  const ComplainProduct(this.idOwner, this.idTransaction, {super.key});
  final String idOwner;
  final String idTransaction;

  @override
  State<ComplainProduct> createState() => _ComplainProduct();
}

class _ComplainProduct extends State<ComplainProduct> {
  final photoController = TextEditingController();
  final complainController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late DocumentReference imgRef;
  bool enabled = false;
  bool haveData = false;
  DocumentReference<Map<String, dynamic>>? referenceCategory;
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
    // listImages.add(image_temp);

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Complain Product"),
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
                                              if (counter >= 2) {
                                                listImages.remove(imageTemp);
                                              }

                                              listImages.add(image);

                                              if (counter != 3) {
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
                      const Text("Complain Description",
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
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return "Complain must be Filled";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                      ),
                      SizedBox(height: _size.height / 50),
                      SizedBox(
                          width: _size.width,
                          height: _size.height / 15,
                          child: ElevatedButton(
                            onPressed: () {
                              uploadFile(listImages, widget.idTransaction,
                                  complainController.text);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NotifComplain()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: hexStringToColor("4164DE"),
                              // padding: const EdgeInsets.only(right: 300, bottom: 40)
                            ),
                            child: const Text("Complain Product",
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
  final refcomplain = FirebaseFirestore.instance.collection('complain').doc();
  final List<String> _arrImageUrls = [];
  print(complainController);
  print(complainController.length);
  print(listImages.length);
  print(listImages);
  for (int i = 0; i < listImages.length; i++) {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('complain-images/${refcomplain.id + i.toString()}');
    reference.putFile(listImages[i]!);
    _arrImageUrls.add(refcomplain.id + i.toString());
  }
  final complain = complainModel(
          transaction: FirebaseFirestore.instance.collection("transaction").doc(id),
          description: complainController,
          image: _arrImageUrls)
      .toJSON();
  await refcomplain.set(complain);
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
