import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemPrice extends StatelessWidget {

  const ItemPrice({Key? key, int? price, this.fontSize}) : _price = price,  super(key: key);

  final double? fontSize;

  final int? _price;

  @override
  Widget build(BuildContext context) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0
    );

    return Container(
      child: Text("Rp. ${currencyFormatter.format(_price)}/hour",style: TextStyle(fontSize: fontSize),),
    );
  }
}
