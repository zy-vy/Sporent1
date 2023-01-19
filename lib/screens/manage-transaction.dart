import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/transaction-card.dart';
import 'package:sporent/screens/detail-transaction1.dart';
import 'package:sporent/screens/color.dart';

import '../component/transaction_card.dart';

class ManageTransaction extends StatelessWidget {
  const ManageTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
          child: const Text("Manage Transaction"),
        ),
        backgroundColor: hexStringToColor("4164DE"),
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(vertical: _size.height/30, horizontal: _size.width/18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            // TransactionCard(),
            // TransactionCard()
          ],
        ),
      ),
    );
  }
}
