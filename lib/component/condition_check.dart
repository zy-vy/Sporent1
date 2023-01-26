import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sporent/component/firebase_image.dart';
import 'package:sporent/component/image_full_screen.dart';
import 'package:sporent/component/loading.dart';
import 'package:sporent/screens/give_review.dart';
import 'package:sporent/screens/notif_transaction.dart';
import 'package:sporent/utils/colors.dart';

class ConditionCheck extends StatefulWidget {
  const ConditionCheck(this.idTransaction, this.title, this.description,
      this.type, this.title_page, this.imageCondition, this.textController,
      {super.key, this.idOwner, this.product_name, this.product_image, this.total, this.idUser, this.idProduct});

  final String? idOwner;
  final String? idTransaction;
  final String? title;
  final String? description;
  final String? type;
  final String? title_page;
  final String? imageCondition;
  final String? textController;
  final String? product_name;
  final String? product_image;
  final int? total;
  final String? idUser;
  final String? idProduct;

  @override
  State<ConditionCheck> createState() => _ConditionCheckState();
}

class _ConditionCheckState extends State<ConditionCheck> {
  final photoController = TextEditingController();
  final controller = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  File? temp;
  File? image;
  bool loading = false;

  Future openCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.camera);
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
                child: Text(widget.title_page!),
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
                          widget.imageCondition == ""
                              ? Stack(children: [
                                  Container(
                                    width: _size.width / 5,
                                    height: _size.height / 10,
                                    decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: BorderSide(
                                                width: 2,
                                                color: HexColor("868686")))),
                                    child: TextButton(
                                      onPressed: () async {
                                        await openCamera();
                                      },
                                      child: image != null
                                          ? Image.file(image!)
                                          : FaIcon(
                                              FontAwesomeIcons.plus,
                                              color: HexColor("4164DE"),
                                              size: 35,
                                            ),
                                    ),
                                  ),
                                  image != null
                                      ? Positioned(
                                          right: 0,
                                          child: Container(
                                              height: 25,
                                              width: 25,
                                              decoration: const BoxDecoration(
                                                  color: Colors.blueAccent,
                                                  shape: BoxShape.circle),
                                              child: IconButton(
                                                icon: const FaIcon(
                                                    FontAwesomeIcons.xmark,
                                                    size: 10,
                                                    color: Colors.white),
                                                onPressed: () {
                                                  setState(() {
                                                    image = null;
                                                  });
                                                },
                                              )),
                                        )
                                      : const Positioned(
                                          right: 0, top: 0, child: SizedBox())
                                ])
                              : GestureDetector(
                                  child: Container(
                                      width: _size.width / 5,
                                      height: _size.height / 10,
                                      decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                  width: 2,
                                                  color: HexColor("868686")))),
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: FirebaseImage(
                                        filePath:
                                            "condition-check/${widget.imageCondition}",
                                      ))),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => FullScreen(
                                                "firebaseImage", filePath: "condition-check", firebaseImage: widget.imageCondition,)));
                                  },
                                ),
                          SizedBox(height: _size.height / 23),
                          widget.idOwner == ""
                              ? const SizedBox()
                              : widget.title_page == "Return Product"
                                  ? StreamBuilder(
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text("Delivery Information",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              SizedBox(
                                                  height: _size.height / 50),
                                              Text(snapshot.data!
                                                  .get("owner_address")),
                                              SizedBox(
                                                  height: _size.height / 23),
                                            ],
                                          );
                                        }
                                      },
                                    )
                                  : const SizedBox(),
                          SizedBox(height: _size.height / 60),
                          Text(widget.title!,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          SizedBox(height: _size.height / 50),
                          widget.textController != ""
                              ? Text(widget.textController!,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400))
                              : TextFormField(
                                  controller: controller,
                                  keyboardType: TextInputType.multiline,
                                  minLines: 1,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelText: widget.description),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "${widget.type} must be Filled";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                          SizedBox(height: _size.height / 20),
                          widget.textController != ""
                              ? const SizedBox()
                              : SizedBox(
                                  width: _size.width,
                                  height: _size.height / 12,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          setState(() {
                                            loading = true;
                                          });
                                          if (widget.title_page ==
                                              "Return Product") {
                                            final ref = FirebaseStorage.instance
                                                .ref()
                                                .child("condition-check")
                                                .child(
                                                    "${widget.idTransaction}_user_after");
                                            await ref.putFile(image!);

                                            FirebaseFirestore.instance
                                                .collection("transaction")
                                                .doc(widget.idTransaction)
                                                .update({
                                              "tracking_code_user":
                                                  controller.text,
                                              "image_after_user":
                                                  "${widget.idTransaction}_user_after",
                                              "status": "RETURN",
                                              "date_after_user" : DateTime.now()
                                            
                                            });

                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotifTransaction(widget.product_name!, widget.product_image!, widget.total!, widget.idProduct!, widget.idUser!),));
                                          
                                          } else {
                                            final ref = FirebaseStorage.instance
                                                .ref()
                                                .child("condition-check")
                                                .child(
                                                    "${widget.idTransaction}_user_before");
                                            await ref.putFile(image!);

                                            FirebaseFirestore.instance
                                                .collection("transaction")
                                                .doc(widget.idTransaction)
                                                .update({
                                              "image_before_user":
                                                  "${widget.idTransaction}_user_before",
                                              "description_before_user":
                                                  controller.text,
                                              "status": "ACTIVE",
                                              "date_before_user" : DateTime.now()
                                            });

                                            Navigator.of(context).pop();
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            hexStringToColor("4164DE"),
                                      ),
                                      child: widget.title_page !=
                                              "Return Product"
                                          ? const Text(
                                              "Submit",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : const Text(
                                              "Return Product",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                )
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
