import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/screens/change-password.dart';
import 'package:sporent/screens/deposit-information.dart';
import 'package:sporent/screens/input-renter-name.dart';
import '/firebase_options.dart';
import 'package:sporent/screens/edit-personal-info.dart';
import 'package:sporent/screens/help-center.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Padding(
              padding: EdgeInsets.only(top: _size.height / 16),
              child: Column(
                  children: const [
                    TopProfile(),
                    NameUser(),
                    RenterButton(),
                    DetailProfile(),
                    DetailDeposit(),
                    DetailPassword(),
                    DetailHelp(),
                    LogOutButton()
                  ],
                ),
              ),
        ));
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

class RenterButton extends StatelessWidget {
  const RenterButton({super.key});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: _size.height / 80),
      child: SizedBox(
        width: 230,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const InputRenterName(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(backgroundColor: HexColor("4164DE")),
          child: const Text(
            "Become Renter",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
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

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: _size.height/50),
      child: TextButton(
          onPressed: () {},
          child: Text("Log Out",
              style: TextStyle(
                  color: HexColor("DE4141"),
                  fontWeight: FontWeight.bold,
                  fontSize: 18))),
    );
  }
}

class DetailProfile extends StatelessWidget {
  const DetailProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
          left: _size.width / 8,
          right: _size.width / 15,
          top: _size.height / 60),
      child: Container(
        height: 70,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.4, color: Colors.grey))),
        child: TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const EditPersonalInfo(),
                ),
              );
            },
            child: Row(
              children: [
                Image.asset("assets/icons/EditPersonal.png", height: 40),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: _size.width / 20, right: _size.width / 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Edit Personal Info",
                            style:
                                TextStyle(color: Colors.black, fontSize: 20)),
                        Text("Name, Phone, Email Address",
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_right_outlined,
                    color: Colors.black, size: 40)
              ],
            )),
      ),
    );
  }
}

class DetailDeposit extends StatelessWidget {
  const DetailDeposit({super.key});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
          left: _size.width / 8,
          right: _size.width / 15,
          top: _size.height / 70),
      child: Container(
        height: 70,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.4, color: Colors.grey))),
        child: TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DepositInformation(),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/icons/Deposit.png", height: 33),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: _size.width / 30, right: _size.width / 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Deposit Information",
                            style:
                                TextStyle(color: Colors.black, fontSize: 20)),
                        Text("All information about deposit",
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_right_outlined,
                    color: Colors.black, size: 40)
              ],
            )),
      ),
    );
  }
}

class DetailPassword extends StatelessWidget {
  const DetailPassword({super.key});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
          left: _size.width / 8,
          right: _size.width / 15,
          top: _size.height / 70),
      child: Container(
        height: 70,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.4, color: Colors.grey))),
        child: TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const EditPassword(),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/icons/ChangePassword.png", height: 35),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: _size.width / 25, right: _size.width / 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Change Password",
                            style:
                                TextStyle(color: Colors.black, fontSize: 20)),
                        Text("Change your old password",
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_right_outlined,
                    color: Colors.black, size: 40)
              ],
            )),
      ),
    );
  }
}

class DetailHelp extends StatelessWidget {
  const DetailHelp({super.key});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
          left: _size.width / 8,
          right: _size.width / 15,
          top: _size.height / 70),
      child: Container(
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/icons/HelpCenter.png", height: 35),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: _size.width / 25, right: _size.width / 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Help Center",
                            style:
                                TextStyle(color: Colors.black, fontSize: 20)),
                        Text("Solution for your problem",
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_right_outlined,
                    color: Colors.black, size: 40)
              ],
            )),
      ),
    );
  }
}
