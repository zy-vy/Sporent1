import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../screens/detail-help-center.dart';

class FieldHelpCenter extends StatelessWidget {
  const FieldHelpCenter(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: HexColor("D6D6D6")),
            ),
          ),
          child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(left: 1),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DetailHelpCenter(),
                  ),
                );
              },
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text("Perpanjang Batas Waktu Proses Pesanan",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black)),
              )),
        ),
        SizedBox(height: _size.height / 60),
      ],
    );
  }
}
