import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sporent/screens/manage_balance_admin.dart';

import '../component/field_row.dart';
import '../component/image_full_screen.dart';
import '../model/request.dart';

class DetailInformation extends StatefulWidget {
  const DetailInformation(this.request, this.role, this.image, {super.key});

  final Request request;
  final String role;
  final String image;

  @override
  State<DetailInformation> createState() => _DetailInformationState();
}

class _DetailInformationState extends State<DetailInformation> {
  File? image;
  bool haveImage = false;

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
    NumberFormat currencyFormatter =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Balance Detail"),
          ),
          backgroundColor: HexColor("4164DE"),
        ),
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: _size.width / 15, vertical: _size.height / 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Status: ${widget.request.status}",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: _size.height / 70),
              Divider(color: HexColor("E0E0E0"), thickness: 2),
              SizedBox(height: _size.height / 70),
              const Text("Bank Information",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              SizedBox(height: _size.height / 30),
              FieldRow("Bank Name", widget.request.bank_name!, true, 14,
                  FontWeight.normal, FontWeight.w600),
              SizedBox(height: _size.height / 30),
              FieldRow("Account Number", widget.request.account_number!, true,
                  14, FontWeight.normal, FontWeight.w600),
              SizedBox(height: _size.height / 30),
              FieldRow("Account Name", widget.request.account_name!, true, 14,
                  FontWeight.normal, FontWeight.w600),
              SizedBox(height: _size.height / 30),
              FieldRow(
                  "Amount",
                  currencyFormatter.format(widget.request.amount),
                  true,
                  14,
                  FontWeight.normal,
                  FontWeight.w600),
              SizedBox(height: _size.height / 30),
              const Text(
                "Proof of Payment",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
              ),
              SizedBox(height: _size.height / 30),
              widget.role == "admin"
                  ? Stack(children: [
                      Container(
                        width: _size.width / 5,
                        height: _size.height / 10,
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                    width: 2, color: HexColor("868686")))),
                        child: TextButton(
                          onPressed: () async {
                            await openGallery();
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
                                    icon: const FaIcon(FontAwesomeIcons.xmark,
                                        size: 10, color: Colors.white),
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
                  : widget.image != ""
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
                                      imageUrl: widget.image,
                                      fit: BoxFit.fill,
                                      width: _size.width / 5,
                                      height: _size.height / 10,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                    )),
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => FullScreen("url",
                                          url: widget.image)),
                                );
                              },
                            )
                      : const Text("Request is still being processed, please wait"),
              SizedBox(height: _size.height / 20),
              widget.role == "admin"
                  ? SizedBox(
                      width: _size.width,
                      height: _size.height / 15,
                      child: ElevatedButton(
                        onPressed: () async {
                          final ref = FirebaseStorage.instance
                              .ref()
                              .child('payment/')
                              .child("${widget.request.id}_payment_admin.jpg");
                          await ref.putFile(image!);

                          String url = await ref.getDownloadURL();

                          FirebaseFirestore.instance
                              .collection("request")
                              .doc(widget.request.id)
                              .update({"status": "Finished", "image": url});

                          CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.success,
                                  text: "Success return balance...")
                              .then((value) => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ManageBalance(),
                                    ),
                                  ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor("4164DE"),
                        ),
                        child:
                            const Text("Confirm", textAlign: TextAlign.center),
                      ))
                  : const SizedBox()
            ],
          ),
        ));
  }
}
