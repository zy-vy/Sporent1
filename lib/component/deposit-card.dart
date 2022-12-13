import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../screens/deposit-detail.dart';

class DepositCard extends StatefulWidget {
  const DepositCard({super.key});

  @override
  State<DepositCard> createState() => _DepositCardState();
}

class _DepositCardState extends State<DepositCard> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return DecoratedBox(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: HexColor("CCCCCC")))),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: _size.width / 20, vertical: _size.height / 30),
        child: TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DepositDetail(),
                ),
              );
            },
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/tennis-racket.png",
                    width: _size.width / 3,
                    height: _size.height / 5.8,
                  ),
                  SizedBox(width: _size.width / 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "30 August 2022",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      SizedBox(height: _size.height / 90),
                      const Text(
                        "Raket Tenis",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: _size.height / 90),
                      Text(
                        "Status: In Progress",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: HexColor("416DDE")),
                      ),
                      SizedBox(height: _size.height / 95),
                      Text(
                        "Total Deposit:",
                        style:
                            TextStyle(fontSize: 18, color: HexColor("999999")),
                      ),
                      SizedBox(height: _size.height / 98),
                      const Text(
                        "Rp 1.500.000",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )
                    ],
                  )
                ])),
      ),
    );
  }
}
