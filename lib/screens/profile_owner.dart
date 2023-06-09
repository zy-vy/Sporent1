import 'dart:io';
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sporent/screens/ManageOrderScreen.dart';
import 'package:sporent/screens/balance_information.dart';
import 'package:sporent/screens/bottom_bar.dart';
import 'package:sporent/screens/manage-product.dart';
import 'package:sporent/screens/manage-transaction.dart';
import 'package:sporent/screens/profile.dart';
import 'package:sporent/viewmodel/user_viewmodel.dart';
import '../component/bar-profile.dart';
import 'package:sporent/screens/help-center.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sporent/screens/edit_personal_info_owner.dart';

class OwnerProfile extends StatelessWidget {
  const OwnerProfile(this.id, {super.key});

  final String? id;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: const FaIcon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const BottomBarScreen(indexPage: "3",)));
            },
          ),
            centerTitle: false,
            title: Transform(
              transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white),
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(top: _size.height / 25),
            child: StreamBuilder(
                stream: firestore.collection("user").doc(id).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Column(
                      children: [
                        TopProfile(snapshot.data?.data()!["owner_image"],
                            snapshot.data!.id),
                        nameProfile(
                          _size,
                          snapshot.data!.get("owner_name"),
                        ),
                        BarProfile(
                            "Edit Personal Info",
                            "Name, Location, Description",
                            FontAwesomeIcons.solidUser,
                            EditPersonalInfoRenter(snapshot.data!.id)),
                        BarProfile(
                            "Manage Product",
                            "Add, Edit, and Delete product",
                            FontAwesomeIcons.buffer,
                            ManageProduct(snapshot.data!.id)),
                        BarProfile(
                            "Manage Order",
                            "Show all transaction renter",
                            FontAwesomeIcons.receipt,
                            ManageOrderScreen(userViewModel: UserViewModel(),)),
                        BarProfile(
                            "Balance Information",
                            "All information about balance",
                            FontAwesomeIcons.fileInvoiceDollar,
                            BalanceInformation(id)),
                      ],
                    );
                  }
                }),
          ),
        ));
  }
}

class TopProfile extends StatefulWidget {
  TopProfile(this.image, this.id, {super.key});

  String? image;

  final String? id;

  @override
  State<TopProfile> createState() => _TopProfileState();
}

class _TopProfileState extends State<TopProfile> {
  File? image;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future openGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(imagePicked!.path);
    });
  }

  Future saveImage() async {
    var id = widget.id;
    final ref =
        FirebaseStorage.instance.ref().child('owner-images/').child(widget.id!);
    await ref.putFile(image!);

    var linkImage = (await ref.getDownloadURL()).toString();

    firestore.collection("user").doc(id).update({'owner_image': linkImage});

    setState(() {
      widget.image = linkImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Stack(
      children: [
        ClipOval(
            child: widget.image.toString() != "" ? CachedNetworkImage(
              imageUrl: widget.image.toString(),
              fit: BoxFit.cover,
              width: _size.width/2,
              height: _size.height/4,
              placeholder: (context, url) => const CircularProgressIndicator())
              : CachedNetworkImage(
              imageUrl: "https://firebasestorage.googleapis.com/v0/b/sporent-80b28.appspot.com/o/user-images%2Ftemp.jpg?alt=media&token=e56c043d-8297-445d-8631-553d5cfbb0a6",
              fit: BoxFit.fill,
              width: _size.width/2,
              height: _size.height/4,
              placeholder: (context, url) => const CircularProgressIndicator() 
            )
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            height: 70,
            width: 70,
            decoration: const BoxDecoration(
                color: Colors.blueAccent, shape: BoxShape.circle),
            child: TextButton(
                onPressed: () async {
                  await openGallery();
                  await saveImage();
                },
                style: TextButton.styleFrom(foregroundColor: Colors.white),
                child: const ImageIcon(AssetImage("assets/icons/Camera.png"))),
          ),
        ),
      ],
    );
  }
}
