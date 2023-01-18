import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/component-edit.dart';
import 'package:sporent/screens/profile_owner.dart';

import '../component/edit_page.dart';
import '../model/user.dart';

class EditPersonalInfoRenter extends StatefulWidget {
  const EditPersonalInfoRenter(this.id, {super.key});

  final String? id;

  @override
  State<EditPersonalInfoRenter> createState() => _EditPersonalInfoRenterState();
}

class _EditPersonalInfoRenterState extends State<EditPersonalInfoRenter> {
  final TextEditingController controllerUsernameRenter =
      TextEditingController();
  final TextEditingController controlerMunicipality = TextEditingController();
  final TextEditingController controllerAddress = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
                    leading: IconButton(
            icon: const FaIcon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => OwnerProfile(widget.id)));
            },
          ),
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Edit Personal Info"),
          ),
          backgroundColor: HexColor("4164DE"),
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: _size.height / 20, horizontal: _size.width / 20),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("user")
                  .doc(widget.id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  var docOwner = UserLocal.fromDocument(
                      snapshot.data!.id, snapshot.data!.data()!);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Profile Info",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: _size.height / 50),
                      FieldForm(
                          "Name",
                          docOwner.owner_name!,
                          EditPage(
                              widget.id!,
                              "Edit Your Username",
                              "Enter a username for your apps",
                              "Enter your Username",
                              "Username",
                              "owner_name",
                              controllerUsernameRenter,
                              EditPersonalInfoRenter(widget.id)),
                          16,
                          12,
                          5,
                          true),
                      FieldForm(
                          "Municipality",
                          docOwner.owner_municipality!,
                          EditPage(
                              widget.id!,
                              "Edit Your Municipality",
                              "Enter municipality for your page",
                              "Enter your municipality",
                              "Municipality",
                              "owner_municipality",
                              controlerMunicipality,
                              EditPersonalInfoRenter(widget.id)),
                          16,
                          12,
                          12,
                          true),
                      FieldForm(
                          "Address",
                          docOwner.owner_address!,
                          EditPage(
                              widget.id!,
                              "Edit Your Address",
                              "Enter address for your page",
                              "Enter your address",
                              "Address",
                              "owner_address",
                              controllerAddress,
                              EditPersonalInfoRenter(widget.id)),
                          16,
                          12,
                          6.5,
                          true),
                      FieldForm(
                          "Description",
                          docOwner.owner_description!,
                          EditPage(
                                widget.id!,
                              "Edit Your Description",
                              "Enter a description for your page",
                              "Enter your Description",
                              "Description",
                              "owner_description",
                              controllerDescription,
                              EditPersonalInfoRenter(widget.id)),
                          16,
                          12,
                          10.5,
                          true),
                    ],
                  );
                }
              }),
        ));
  }
}
