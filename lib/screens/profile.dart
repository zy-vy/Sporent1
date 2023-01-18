import 'dart:io';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sporent/authentication/models/user_model.dart';
import 'package:sporent/component/bar-profile.dart';
import 'package:sporent/component/firebase_image.dart';
import 'package:sporent/component/no_current_user.dart';
import 'package:sporent/screens/change-password.dart';
import 'package:sporent/screens/deposit-information.dart';
import 'package:sporent/screens/become_owner.dart';
import 'package:sporent/screens/edit_personal_info.dart';
import 'package:sporent/screens/help-center.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sporent/screens/profile_owner.dart';
import 'package:sporent/viewmodel/user_viewmodel.dart';

import '../component/loading.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        body: Center(
      child: Padding(
        padding: EdgeInsets.only(top: _size.height / 16),
        child: SingleChildScrollView(
            child: Consumer<UserViewModel>(
                builder: (context, userViewModel, child) =>
                    userViewModel.isLoggedIn
                        ? Column(
                            children: [
                              TopProfile(userViewModel),
                              nameProfile(_size, userViewModel.user!.name),
                              OwnerButton(userViewModel.user!.is_owner,
                                  userViewModel.user!.id),
                              BarProfile(
                                  "Edit Personal Info",
                                  "Name, Phone, Email Address",
                                  FontAwesomeIcons.solidUser,
                                  EditPersonalInfo(
                                      userViewModel.user!.id.toString())),
                              BarProfile(
                                  "Deposit Information",
                                  "All information about deposit",
                                  FontAwesomeIcons.coins,
                                  DepositInformation(
                                      userViewModel.user!.id.toString())),
                              const BarProfile(
                                  "Change Password",
                                  "Change your old password",
                                  FontAwesomeIcons.lock,
                                  EditPassword()),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: _size.height / 50),
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
                          )
                        : const NoCurrentUser())),
      ),
    ));
  }
}

class TopProfile extends StatefulWidget {
  const TopProfile(this.userViewModel, {super.key});

  final UserViewModel userViewModel;

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
    var id = widget.userViewModel.user!.id.toString();
    final ref = FirebaseStorage.instance.ref().child('user-images/').child(id);
    await ref.putFile(image!);

    var linkImage = (await ref.getDownloadURL()).toString();

    firestore.collection("user").doc(id).update({'image': linkImage});

    setState(() {
      widget.userViewModel.user!.image = linkImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                backgroundImage: widget.userViewModel.user!.image.toString() !=
                        ""
                    ? NetworkImage(widget.userViewModel.user!.image.toString())
                    : const NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/sporent-80b28.appspot.com/o/user-images%2Ftemp.jpg?alt=media&token=e56c043d-8297-445d-8631-553d5cfbb0a6"),
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
                        await saveImage();
                      },
                      style:
                          TextButton.styleFrom(foregroundColor: Colors.white),
                      child: const ImageIcon(
                          AssetImage("assets/icons/Camera.png"))),
                ),
              ),
            ],
          );
  }
}

class OwnerButton extends StatelessWidget {
  const OwnerButton(this.is_owner, this.id, {super.key});

  final bool? is_owner;

  final String? id;

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
            if (is_owner == false) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BecomeOwner(id),
                ),
              );
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OwnerProfile(id),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: HexColor("4164DE")),
          child: const Text(
            "Become Owner",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

Container nameProfile(Size _size, String? name) => Container(
      margin: EdgeInsets.symmetric(vertical: _size.height / 60),
      child: Text(name!,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
    );
