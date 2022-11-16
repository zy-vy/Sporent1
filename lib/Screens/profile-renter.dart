import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:skripsi_sporent/screens/change-password.dart';
import 'package:skripsi_sporent/screens/deposit-information.dart';
import 'package:skripsi_sporent/screens/input-renter-name.dart';
import 'package:skripsi_sporent/screens/manage-product.dart';
import 'package:skripsi_sporent/screens/manage-transaction.dart';
import '/firebase_options.dart';
import 'package:skripsi_sporent/screens/edit-personal-info.dart';
import 'package:skripsi_sporent/screens/help-center.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skripsi_sporent/screens/edit-personal-info-renter.dart';

class RenterProfile extends StatelessWidget {
  const RenterProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: Stack(
          children: const [TopProfile()],
        ),
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
      alignment: Alignment.center,
      children: [
        Positioned(
            top: 50,
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              backgroundImage: image != null
                  ? FileImage(image!) as ImageProvider
                  : const AssetImage("images/5864188.jpg"),
              radius: 100,
            )),
        Positioned(
            top: 190,
            left: 230,
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
                  child: const ImageIcon(AssetImage("images/Camera.png"))),
            )),
        const Positioned(
            top: 280,
            child: Text("Nasrul Ramadhan",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),

        Positioned(
            top: 355,
            left: 60,
            child: Image.asset("images/EditPersonal.png", height: 40)),
        const Positioned(top: 340, child: DetailProfile()),
        const Positioned(
            top: 355,
            left: 320,
            child: Icon(Icons.keyboard_arrow_right_outlined,
                color: Colors.black, size: 40)),


        Positioned(
            top: 440,
            left: 52,
            child: Image.asset("images/Manage Product.png", height: 43)),
        const Positioned(top: 425, child: DetailProduct()),
        const Positioned(
            top: 440,
            left: 320,
            child: Icon(Icons.keyboard_arrow_right_outlined,
                color: Colors.black, size: 40)),


        Positioned(
            top: 525,
            left: 58,
            child: Image.asset("images/Manage Transaction.png", height: 35)),
        const Positioned(top: 510, child: DetailTransaction()),
        const Positioned(
            top: 522,
            left: 320,
            child: Icon(Icons.keyboard_arrow_right_outlined,
                color: Colors.black, size: 40)),


        Positioned(
            top: 608,
            left: 60,
            child: Image.asset("images/HelpCenter.png", height: 42)),
        const Positioned(top: 595, child: DetailHelp()),
        const Positioned(
            top: 608,
            left: 320,
            child: Icon(Icons.keyboard_arrow_right_outlined,
                color: Colors.black, size: 40)),
      ],
    );
  }
}

class DetailProfile extends StatelessWidget {
  const DetailProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.4, color: Colors.grey))),
      child: TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const EditPersonalInfoRenter(),
              ),
            );
          },
          child: Row(
            children: [
              const SizedBox(width: 57),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Edit Personal Info",
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                  Text("Name, Location, Description",
                      style: TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
              const SizedBox(width: 40)
            ],
          )),
    );
  }
}

class DetailProduct extends StatelessWidget {
  const DetailProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.4, color: Colors.grey))),
      child: TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ManageProduct(),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 50),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Manage Product",
                        style: TextStyle(color: Colors.black, fontSize: 20)),
                    Text("Add, Edit, and Delete Product",
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(width: 40)
            ],
          )),
    );
  }
}

class DetailTransaction extends StatelessWidget {
  const DetailTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.4, color: Colors.grey))),
      child: TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ManageTransaction(),
              ),
            );
          },
          child: Row(
            children: [
              const SizedBox(width: 73),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Manage Transaction",
                        style: TextStyle(color: Colors.black, fontSize: 20)),
                    Text("Show all transaction",
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(width: 40)
            ],
          )),
    );
  }
}

class DetailHelp extends StatelessWidget {
  const DetailHelp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.4, color: Colors.grey))),
      child: TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HelpCenter(),
              ),
            );
          },
          child: Row(
            children: [
              const SizedBox(width: 55),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Help Center",
                        style: TextStyle(color: Colors.black, fontSize: 20)),
                    Text("Solution for your problem",
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(width: 40)
            ],
          )),
    );
  }
}
