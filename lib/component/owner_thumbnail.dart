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

  User? _user;


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
        log("+++ user ${user?.id}");
        _user = user;
      });
    }
  }

  Future<User?> getUser() async {
    final userRepository = UserRepository();
    Future<User?> user =  userRepository.getUserByRef(widget.userRef);
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
        User? user = snapshot.data;

      return Card(
        elevation: 3,
        child: Container(
          child: Column(
            children: [
              Text("owner : ${user?.name}")
            ],
          ),
        ),
      );
    },);
  }
}
