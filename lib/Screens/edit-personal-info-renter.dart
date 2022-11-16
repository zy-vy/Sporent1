import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skripsi_sporent/screens/edit-description-renter.dart';
import 'package:skripsi_sporent/screens/edit-location.dart';
import 'package:skripsi_sporent/screens/edit-name-renter.dart';
import 'package:skripsi_sporent/screens/edit-phone.dart';
import 'package:skripsi_sporent/screens/edit-username.dart';
import '/firebase_options.dart';
import 'package:skripsi_sporent/screens/color.dart';
import 'package:skripsi_sporent/screens/edit-name.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:skripsi_sporent/screens/edit-email.dart';
import 'package:skripsi_sporent/screens/edt-gender.dart';
import 'package:skripsi_sporent/screens/edit-birhdate.dart';

class EditPersonalInfoRenter extends StatelessWidget {
  const EditPersonalInfoRenter({super.key});

  @override
  Widget build(BuildContext context) {
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
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 20, right: 35, bottom: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Profile Info",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text("Name",
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(width: 106),
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
                      builder: (context) => const EditNameRenter(),
                    ),
                  );
                },
                icon: const FaIcon(FontAwesomeIcons.chevronRight),
                iconSize: 20,
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text("Location",
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(width: 85),
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
           const SizedBox(height: 10),
          Row(
            children: [
              const Text("Description",
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(width: 64),
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