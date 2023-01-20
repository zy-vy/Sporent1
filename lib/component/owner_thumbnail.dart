import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sporent/repository/user_repository.dart';

import '../model/user.dart';

class OwnerThumbnail extends StatefulWidget {
  const OwnerThumbnail({Key? key, required this.userRef}) : super(key: key);

  final String userRef;

  @override
  State<OwnerThumbnail> createState() => _OwnerThumbnailState();
}



class _OwnerThumbnailState extends State<OwnerThumbnail> {

  UserLocal? _user;


  @override
  void initState() {
    // TODO: implement initState
    // init();
    super.initState();
  }

  Future<void> init() async{
    final user = await getUser();
    if (mounted){
      setState(() {
        // log("+++ user ${user?.id}");
        _user = user;
      });
    }
  }

  Future<UserLocal?> getUser() async {
    final userRepository = UserRepository();
    Future<UserLocal?> user =  userRepository.getUserByRef(widget.userRef);
    return user;
  }


  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository();

    return FutureBuilder(
      future: userRepository.getUserByRef(widget.userRef),
      builder: (context, snapshot) {
        if (!snapshot.hasData){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        UserLocal? user = snapshot.data;

      return Column(
        children: [
          Text("owner : ${user?.name}")
        ],
      );
    },);
  }
}
