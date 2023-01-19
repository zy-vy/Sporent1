import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/screens/deposit-information.dart';
import 'package:sporent/screens/profile_owner.dart';
import 'package:sporent/screens/request_history.dart';

import '../component/information_card.dart';

class BalanceInformation extends StatefulWidget {
  const BalanceInformation(this.id, {super.key});

  final String? id;

  @override
  State<BalanceInformation> createState() => _BalanceInformationState();
}

class _BalanceInformationState extends State<BalanceInformation> {
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
            child: const Text("Balance Information"),
          ),
          backgroundColor: HexColor("4164DE"),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: _size.height / 20),
            child: SingleChildScrollView(
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
                                snapshot.data!.get("owner_balance"),
                                "Get Balance",
                                "Balance",
                                RequestHistory(widget.id!, "Balance"),
                                BalanceInformation(widget.id!),
                                context,
                                _size),
                            SizedBox(
                              height: _size.height / 60,
                            ),
                            InformationCard(widget.id!, "balance")
                          ],
                        );
                      }
                    }),
              ),
            )));
  }
}
