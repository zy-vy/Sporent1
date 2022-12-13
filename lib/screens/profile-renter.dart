import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sporent/screens/manage-product.dart';
import 'package:sporent/screens/manage-transaction.dart';
import '../component/bar-profile.dart';
import 'package:sporent/screens/help-center.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sporent/screens/edit-personal-info-renter.dart';

class RenterProfile extends StatelessWidget {
  const RenterProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            centerTitle: false,
            title: Transform(
              transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            ),
            iconTheme: const IconThemeData(
              color: Colors.black
            ),
            backgroundColor: Colors.white),
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
              padding: EdgeInsets.only(top: _size.height / 16),
              child: Column(
                  children: const [
                    TopProfile(),
                    NameUser(),
                    BarProfile("Edit Personal Info", "Name, Location, Description",FontAwesomeIcons.solidUser, EditPersonalInfoRenter()),
                    BarProfile(
                    "Manage Product",
                    "Add, Edit, and Delete product",
                    FontAwesomeIcons.buffer,
                    ManageProduct()),
                    BarProfile("Manage Transaction", "Show all transaction renter",
                    FontAwesomeIcons.receipt, ManageTransaction()),
                    BarProfile("Help Center", "Solution for your problem",
                    FontAwesomeIcons.question, HelpCenter()),
                  ],
                ),
              ),
        )
    );
  }
}

class TopProfile extends StatefulWidget {
  const TopProfile({super.key});

  @override
  State<TopProfile> createState() => _TopProfileState();
}

class _TopProfileState extends State<TopProfile> {
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
    return Stack(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          backgroundImage: image != null
              ? FileImage(image!) as ImageProvider
              : const AssetImage("assets/images/5864188.jpg"),
          radius: 100,
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
                },
                style: TextButton.styleFrom(foregroundColor: Colors.white),
                child: const ImageIcon(AssetImage("assets/icons/Camera.png"))),
          ),
        ),
      ],
    );
  }
}

class NameUser extends StatelessWidget {
  const NameUser({super.key});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: _size.height / 60),
      child: const Text("Nasrul Ramadhan",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
    );
  }
}