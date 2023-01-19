import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/information_card.dart';

class RequestHistory extends StatelessWidget {
  const RequestHistory(this.id, this.type, {super.key});

  final String id;

  final String type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
          child: Text("Request $type"),
        ),
        backgroundColor: HexColor("4164DE"),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
          child: type == "Balance"
              ? InformationCard(id, "request", field: "balance")
              : InformationCard(id, "request", field: "deposit")),
    );
  }
}
