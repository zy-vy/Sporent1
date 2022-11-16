import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sporent/screens/change-password.dart';
import 'package:sporent/screens/deposit-information.dart';
import '/firebase_options.dart';
import 'package:sporent/screens/edit-personal-info.dart';
import 'package:sporent/screens/help-center.dart';
import 'package:image_picker/image_picker.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int indexPage = 3;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: const [TopProfile()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                label: 'Home',
                icon: ImageIcon(AssetImage("images/Home Before.png")),
                activeIcon: ImageIcon(AssetImage("images/Home After.png"))),
            BottomNavigationBarItem(
                label: 'Transaction',
                icon: ImageIcon(AssetImage("images/Transaction Before.png")),
                activeIcon:
                    ImageIcon(AssetImage("images/Transaction After.png"))),
            BottomNavigationBarItem(
                label: 'Cart',
                icon: ImageIcon(AssetImage("images/Cart Before.png")),
                activeIcon: ImageIcon(AssetImage("images/Cart After.png"))),
            BottomNavigationBarItem(
                label: 'Profile',
                icon: ImageIcon(AssetImage("images/Profile Before.png")),
                activeIcon: ImageIcon(AssetImage("images/Profile After.png")))
          ],
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          currentIndex: indexPage,
          onTap: (int index) {
            setState(() {
              indexPage = index;
            });
          },
        ),
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
            top: 60,
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              backgroundImage: image != null
                  ? FileImage(image!) as ImageProvider
                  : AssetImage("images/5864188.jpg"),
              radius: 100,
            )),
        Positioned(
            top: 200,
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
            top: 300,
            child: Text("Nasrul Ramadhan",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
        Positioned(
            top: 395,
            left: 60,
            child: Image.asset("images/EditPersonal.png", height: 40)),
        const Positioned(top: 380, child: DetailProfile()),
        const Positioned(
            top: 390,
            left: 320,
            child: Icon(Icons.keyboard_arrow_right_outlined,
                color: Colors.black, size: 40)),
        Positioned(
            top: 495,
            left: 52,
            child: Image.asset("images/Deposit.png", height: 35)),
        const Positioned(top: 480, child: DetailDeposit()),
        const Positioned(
            top: 490,
            left: 320,
            child: Icon(Icons.keyboard_arrow_right_outlined,
                color: Colors.black, size: 40)),
        Positioned(
            top: 595,
            left: 60,
            child: Image.asset("images/ChangePassword.png", height: 38)),
        const Positioned(top: 580, child: DetailPassword()),
        const Positioned(
            top: 590,
            left: 320,
            child: Icon(Icons.keyboard_arrow_right_outlined,
                color: Colors.black, size: 40)),
        Positioned(
            top: 695,
            left: 60,
            child: Image.asset("images/HelpCenter.png", height: 38)),
        const Positioned(top: 680, child: DetailHelp()),
        const Positioned(
            top: 690,
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
                builder: (context) => const EditPersonalInfo(),
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
                  Text("Name, Phone, Email Address",
                      style: TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
              const SizedBox(width: 40)
            ],
          )),
    );
  }
}

class DetailDeposit extends StatelessWidget {
  const DetailDeposit({super.key});

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
                builder: (context) => const DepositInformation(),
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
                    Text("Deposit Information",
                        style: TextStyle(color: Colors.black, fontSize: 20)),
                    Text("All information about deposit",
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

class DetailPassword extends StatelessWidget {
  const DetailPassword({super.key});

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
                builder: (context) => const EditPassword(),
              ),
            );
          },
          child: Row(
            children: [
              const SizedBox(width: 59),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Change Password",
                        style: TextStyle(color: Colors.black, fontSize: 20)),
                    Text("Change your old password",
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
