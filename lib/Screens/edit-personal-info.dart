import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skripsi_sporent/edit-phone.dart';
import 'package:skripsi_sporent/edit-username.dart';
import 'firebase_options.dart';
import 'package:skripsi_sporent/color.dart';
import 'package:skripsi_sporent/edit-name.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:skripsi_sporent/edit-email.dart';
import 'package:skripsi_sporent/edt-gender.dart';
import 'package:skripsi_sporent/edit-birhdate.dart';

class EditPersonalInfo extends StatelessWidget {
  const EditPersonalInfo({super.key});

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
        body: Stack(children: const [ProfileInfo(), PersonalInfo()]));
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
                      builder: (context) => const EditName(),
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
              const Text("Username",
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(width: 73),
              Expanded(
                  child: Text("Create unique username",
                      style: TextStyle(
                        fontSize: 12,
                        color: HexColor("B0B0B0"),
                      ))),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const EditUsername(),
                    ),
                  );
                },
                icon: const FaIcon(FontAwesomeIcons.chevronRight),
                iconSize: 20,
              )
            ],
          ),
          const SizedBox(height: 15),
          Divider(color: hexStringToColor("E6E6E6"), thickness: 2)
        ],
      ),
    );
  }
}

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 240, left: 20, right: 35, bottom: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Personal Info",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              const Text("E-mail",
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(width: 104),
              const Expanded(
                  child: Text("nasrul24@gmail.com",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold))),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const EditEmail(),
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
              const Text("Phone Number",
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(width: 35),
              Expanded(
                  child: Text("Input phone number",
                      style:
                          TextStyle(fontSize: 12, color: HexColor("B0B0B0")))),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const EditPhone(),
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
              const Text("Gender",
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(width: 96),
              Expanded(
                  child: Text("Input gender",
                      style:
                          TextStyle(fontSize: 12, color: HexColor("B0B0B0")))),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const EditGender(),
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
              const Text("Birhdate",
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(width: 87),
              const Expanded(
                  child: Text("20 January 2001",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold))),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const EditBirthdate(),
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
