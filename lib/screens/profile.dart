import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sporent/authentication/models/user_model.dart';
import 'package:sporent/component/bar-profile.dart';
import 'package:sporent/screens/change-password.dart';
import 'package:sporent/screens/deposit-information.dart';
import 'package:sporent/screens/input-renter-name.dart';
import 'package:sporent/screens/edit-personal-info.dart';
import 'package:sporent/screens/help-center.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sporent/viewmodel/user_viewmodel.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(top: _size.height / 16),
            child: SingleChildScrollView(
              child: Consumer<UserViewModel>(
                builder: (context, userViewModel, child) => Column(
                  children: [
                    const TopProfile(),
                    Text("${userViewModel.user?.name}",
                        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                    const RenterButton(),
                    const BarProfile("Edit Personal Info", "Name, Phone, Email Address",FontAwesomeIcons.solidUser, EditPersonalInfo()),
                    const BarProfile(
                        "Deposit Information",
                        "All information about deposit",
                        FontAwesomeIcons.coins,
                        DepositInformation()),
                    const BarProfile("Change Password", "Change your old password",
                        FontAwesomeIcons.lock, EditPassword()),
                    const BarProfile("Help Center", "Solution for your problem",
                        FontAwesomeIcons.solidCircleQuestion, HelpCenter()),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: _size.height / 50),
                      child: TextButton(
                          onPressed: () {
                            userViewModel.signOut();
                          },
                          child: Text("Log Out",
                              style: TextStyle(
                                  color: HexColor("DE4141"),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18))),
                    )
                  ],
                ),
              )
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
        width: _size.width / 1.8,
        height: _size.height / 18,
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

Widget nameUser(Size _size) {
  return  Consumer<UserViewModel>(builder: (context, userViewModel, child) => Container(
    margin: EdgeInsets.symmetric(vertical: _size.height / 60),
    child: Text("${userViewModel.user?.name}",
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
  ),);
}

// Container logOutButton(Size _size) =>
