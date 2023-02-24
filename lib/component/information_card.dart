import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sporent/component/information_card_detail.dart';
import 'package:sporent/model/deposit.dart';
import 'package:sporent/screens/cashout_screen.dart';
import 'package:sporent/screens/detail_information.dart';
import '../model/balance.dart';
import '../model/request.dart';

class InformationCard extends StatefulWidget {
  const InformationCard(this.id, this.type, {super.key, this.field});

  final String id;

  final String type;

  final String? field;

  @override
  State<InformationCard> createState() => _InformationCardState();
}

class _InformationCardState extends State<InformationCard> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    bool showLine;
    String image = "";
    Deposit deposit = Deposit();
    Balance balance = Balance();
    Request request = Request();
    String name_field = "";
    if (widget.type == "deposit") {
      name_field = "user";
    } else if (widget.type == "balance") {
      name_field = "owner";
    } else {
      name_field = "name_request";
    }

    return StreamBuilder(
        stream: widget.type == "request"
            ? firestore
                .collection(widget.type)
                .orderBy('date', descending: true)
                .where(name_field,
                    isEqualTo: firestore.collection("user").doc(widget.id))
                .where("type", isEqualTo: widget.field)
                .snapshots()
            : widget.type == "admin"
                ? firestore
                    .collection("request")
                    .orderBy('date', descending: true)
                    .snapshots()
                : firestore
                    .collection(widget.type)
                    .orderBy('date', descending: true)
                    .where(name_field,
                        isEqualTo: firestore.collection("user").doc(widget.id))
                    .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("There is no ${widget.type} history"),
            );
          } else {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                if (widget.type == "deposit") {
                  deposit = Deposit.fromDocument(snapshot.data!.docs[index].id,
                      snapshot.data!.docs[index].data());
                } else if (widget.type == "balance") {
                  balance = Balance.fromDocument(snapshot.data!.docs[index].id,
                      snapshot.data!.docs[index].data());
                } else {
                  request = Request.fromDocument(snapshot.data!.docs[index].id,
                      snapshot.data!.docs[index].data());
                  if (snapshot.data!.docs[index].data().containsKey("image") ==
                      true) {
                    image = snapshot.data!.docs[index].get("image");
                  }
                }

                if (index == 0) {
                  showLine = false;
                } else {
                  showLine = true;
                }

                return widget.type == "deposit"
                    ? DetailInformationCard(showLine, "deposit",
                        deposit: deposit)
                    : widget.type == "balance"
                        ? DetailInformationCard(showLine, "balance",
                            balance: balance)
                        : TextButton(
                            style: TextButton.styleFrom(foregroundColor: Colors.black),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DetailInformation(
                                      request, "user", image)));
                            },
                            child: DetailInformationCard(showLine, "request",
                                request: request));
              },
            );
          }
        });
  }
}

Column topPageInformation(String id, int amount, String text, String type,
        Widget page, Widget page2, BuildContext context, Size size) =>
    Column(
      children: [
        Text(
            NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                .format(amount),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35)),
        SizedBox(height: size.height / 30),
        SizedBox(
          width: size.width / 2.1,
          height: size.height / 18,
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CashoutScreen(type, page2, amount, id),
                ));
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: HexColor("4164DE")),
              child: Text(text,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white))),
        ),
        SizedBox(height: size.height / 30),
        TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => page,
              ));
            },
            child: Text("Request History",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: HexColor("4164DE")))),
      ],
    );
