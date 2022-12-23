import 'package:flutter/material.dart';
import 'package:sporent/component/deposit-card.dart';
import 'package:sporent/screens/color.dart';

class DepositInformation extends StatefulWidget {
  const DepositInformation({super.key});

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
        body: Column(
              children: const [
                DepositCard(),
                DepositCard()
              ],
            ));
  }
}
