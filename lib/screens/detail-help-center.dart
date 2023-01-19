import 'package:flutter/material.dart';
import 'package:sporent/screens/color.dart';

class DetailHelpCenter extends StatefulWidget {
  const DetailHelpCenter({super.key});

  @override
  State<DetailHelpCenter> createState() => _DetailHelpCenterState();
}

class _DetailHelpCenterState extends State<DetailHelpCenter> {
  TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
          child: const Text("Detail Help Center"),
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
          const Text("Perpanjang Batas Waktu Proses Pesanan", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: _size.height/70),
          const Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.")
          ]
      )
    )
    );
  }
}
