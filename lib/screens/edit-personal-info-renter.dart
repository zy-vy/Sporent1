import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sporent/screens/edit-description-renter2.dart';
import 'package:sporent/screens/edit-location.dart';
import 'package:sporent/screens/edit-username-renter.dart';
import 'package:sporent/screens/edit-phone.dart';
import 'package:sporent/screens/edit-username.dart';
import '/firebase_options.dart';
import 'package:sporent/screens/color.dart';
import 'package:sporent/screens/edit-username.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/screens/edit-email.dart';
import 'package:sporent/screens/edt-gender.dart';
import 'package:sporent/screens/edit-birhdate.dart';

class EditPersonalInfoRenter extends StatelessWidget {
  const EditPersonalInfoRenter({super.key});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Edit Personal Info"),
          ),
          backgroundColor: hexStringToColor("4164DE"),
        ),
        body: Stack(children: const [ProfileInfo()]));
  }
}

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: _size.height/20, horizontal: _size.width/20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Profile Info",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: _size.height/50),
          Row(
            children: [
              const Text("Name",
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              SizedBox(width: _size.width/5),
              const Expanded(
                  child: Text("Nasrul Ramadhan",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold))),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const EditUsernameRenter(),
                    ),
                  );
                },
                icon: const FaIcon(FontAwesomeIcons.chevronRight),
                iconSize: 20,
              )
            ],
          ),
          SizedBox(height: _size.height/75),
          Row(
            children: [
              const Text("Location",
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              SizedBox(width: _size.width/6.8),
              Expanded(
                  child: Text("Set Location",
                      style: TextStyle(
                        fontSize: 12,
                        color: HexColor("B0B0B0"),
                      ))),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const EditLocationRenter(),
                    ),
                  );
                },
                icon: const FaIcon(FontAwesomeIcons.chevronRight),
                iconSize: 20,
              )
            ],
          ),
          SizedBox(height: _size.height/75),
          Row(
            children: [
              const Text("Description",
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              SizedBox(width: _size.width/10.5),
              Expanded(
                  child: Text("Input description",
                      style: TextStyle(
                        fontSize: 12,
                        color: HexColor("B0B0B0"),
                      ))),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const EditDescriptionRenter(),
                    ),
                  );
                },
                icon: const FaIcon(FontAwesomeIcons.chevronRight),
                iconSize: 20,
              )
            ],
          ),
        ],
      ),
    );
  }
}