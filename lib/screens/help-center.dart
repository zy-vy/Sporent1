import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sporent/screens/color.dart';
import 'package:sporent/screens/detail-help-center.dart';
import 'package:sporent/screens/profile.dart';

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
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: HexColor("D6D6D6")),
              ),
            ),
            child: 
              TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(left: 1),
              ),
              onPressed: (){
                  Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DetailHelpCenter(),
                  ),
              );
            },
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text("Perpanjang Batas Waktu Proses Pesanan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black)),
              ) 
            ),
          ),
          SizedBox(height: _size.height/60),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: HexColor("D6D6D6")),
              ),
            ),
            child: 
              TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(left: 1),
              ),
              onPressed: (){
                  Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DetailHelpCenter(),
                  ),
              );
              }, 
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text("Perpanjang Batas Waktu Proses Pesanan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black)),
              ) 
            ),
          ),
          SizedBox(height: _size.height/60),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: HexColor("D6D6D6")),
              ),
            ),
            child: 
              TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(left: 1),
              ),
              onPressed: (){
                  Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DetailHelpCenter(),
                  ),
              );
              }, 
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text("Perpanjang Batas Waktu Proses Pesanan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black)),
              ) 
            ),
          ),
        ]
      )
    )
    );
  }
}
