import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/information_card.dart';

import '../component/information_card_detail.dart';
import '../model/request.dart';
import 'detail_information.dart';

class ManageBalance extends StatelessWidget {
  const ManageBalance({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    bool showLine = false;

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Manage Balance"),
          ),
          backgroundColor: HexColor("4164DE"),
        ),
        resizeToAvoidBottomInset: true,
        body: StreamBuilder(
            stream: firestore.collection("request").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text("There is no request"),
                );
              } else {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Request request = Request.fromDocument(
                        snapshot.data!.docs[index].id,
                        snapshot.data!.docs[index].data());

                    if (index == 0) {
                      showLine = false;
                    } else {
                      showLine = true;
                    }

                    return TextButton(
                      style:
                          TextButton.styleFrom(foregroundColor: Colors.black),
                      onPressed: request.status == "Finished" ? null : () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailInformation(request)));
                      },
                      child: DetailInformationCard(showLine, "admin",
                          request: request),
                    );
                  },
                );
              }
            }));
  }
}
