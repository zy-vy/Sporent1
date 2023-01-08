import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class ItemPrice extends StatelessWidget {
  const ItemPrice({Key? key, this.price, this.fontSize, this.trail, this.color})
      : super(key: key);

  final double? fontSize;

  final int? price;

  final bool? trail;

  final String? color;

  @override
  Widget build(BuildContext context) {
    NumberFormat currencyFormatter =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(currencyFormatter.format(price),
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: HexColor(color!))),
          Text(
              trail != null
                  ? trail!
                      ? "/Day"
                      : ""
                  : "",
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: HexColor(color!))),
        ],
      ),
    );
  }
}
