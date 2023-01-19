import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sporent/component/information_card.dart';
import 'package:sporent/screens/color.dart';
import 'package:sporent/screens/profile_owner.dart';
import 'package:sporent/screens/request_history.dart';

class DepositInformation extends StatefulWidget {
  const DepositInformation(this.id, {super.key});

  final String id;

  @override
  State<DepositInformation> createState() => _DepositInformationState();
}

class _DepositInformationState extends State<DepositInformation> {
  TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Deposit Information"),
          ),
          backgroundColor: hexStringToColor("4164DE"),
        ),
        resizeToAvoidBottomInset: true,
        body: Padding(
            padding: EdgeInsets.only(top: _size.height / 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Center(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("user")
                        .doc(widget.id)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return Column(
                          children: [
                            topPageInformation(
                                snapshot.data!.id,
                                snapshot.data!.get("deposit"),
                                "Get Deposit",
                                "Deposit",
                                RequestHistory(widget.id, "Deposit"),
                                DepositInformation(widget.id),
                                context,
                                _size),
                            SizedBox(
                              height: _size.height / 60,
                            ),
                            InformationCard(widget.id, "deposit")
                          ],
                        );
                      }
                    }),
              ),
            )));
  }
}
