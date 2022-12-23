import 'package:flutter/material.dart';
import 'package:sporent/component/help-center-field.dart';
import 'package:sporent/screens/color.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
          child: const Text("Help Center"),
        ),
        backgroundColor: hexStringToColor("4164DE"),
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(vertical: _size.height/30, horizontal: _size.width/20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          const Text("What can we help you?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: _size.height/60),
          const FieldHelpCenter("Perpanjang Batas Waktu Proses Pesanan"),
          const FieldHelpCenter("Perpanjang Batas Waktu Proses Pesanan"),
          const FieldHelpCenter("Perpanjang Batas Waktu Proses Pesanan")
        ]
      )
    )
    );
  }
}
