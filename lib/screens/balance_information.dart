import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class BalanceInformation extends StatelessWidget {
  const BalanceInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
          child: const Text("Balance Information"),
        ),
        backgroundColor: HexColor("4164DE"),
      ),
    );
  }
}