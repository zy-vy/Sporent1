import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DetailProductCard extends StatelessWidget {
  const DetailProductCard(this.fontTitle, this.fontProduct, this.fontDuration, this.fontTotal, this.text, {super.key});

  final double? fontTitle;
  final double? fontProduct;
  final double? fontDuration;
  final double? fontTotal;
  final String text;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: _size.height / 70),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Detail Product",
                    style: TextStyle(
                        fontSize: fontTitle,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: _size.height / 50),
                  Row(
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
                          Text(
                            "Raket Tenis",
                            style: TextStyle(
                                fontSize: fontProduct,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(height: _size.height / 80),
                          Text(
                            "Time: 2 hour",
                            style: TextStyle(fontSize: fontDuration),
                          ),
                          SizedBox(height: _size.height / 60),
                          Text(
                            text,
                            style:
                                TextStyle(fontSize: fontTotal, color: HexColor("999999")),
                          ),
                          SizedBox(height: _size.height / 95),
                          Text(
                            "Rp 1.500.000",
                            style: TextStyle(
                                fontSize: fontTotal,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        ],
                      )
                    ],
                  ),
                ])),
          Divider(color: HexColor("E0E0E0"), thickness: 2),
      ],
    );
  }
}
