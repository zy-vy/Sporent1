import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/information_card.dart';
import 'package:sporent/screens/detail_information.dart';

import '../component/information_card_detail.dart';
import '../model/request.dart';

class RequestHistory extends StatefulWidget {
  const RequestHistory(this.id, this.type, {super.key});

  final String id;

  final String type;

  @override
  State<RequestHistory> createState() => _RequestHistoryState();
}

class _RequestHistoryState extends State<RequestHistory> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool showLine = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: Text("Request ${widget.type}"),
          ),
          backgroundColor: HexColor("4164DE"),
        ),
        resizeToAvoidBottomInset: true,
        body: StreamBuilder(
            stream: firestore
                .collection("request")
                .where('name_request',
                    isEqualTo: firestore.collection("user").doc(widget.id))
                .where("type", isEqualTo: widget.type.toLowerCase())
                .orderBy('date', descending: true)
                .snapshots(),
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
                     String? image = "";
                    Request request = Request.fromDocument(
                        snapshot.data!.docs[index].id,
                        snapshot.data!.docs[index].data());
                    if (snapshot.data!.docs[index]
                            .data()
                            .containsKey("image") ==
                        true) {
                      image = snapshot.data!.docs[index].get("image");
                    } 

                    if (index == 0) {
                      showLine = false;
                    } else {
                      showLine = true;
                    }

                    return TextButton(
                        style:
                            TextButton.styleFrom(foregroundColor: Colors.black),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  DetailInformation(request, "user", image!)));
                        },
                        child: DetailInformationCard(showLine, "request",
                            request: request));
                  },
                );
              }
            }));
  }
}
