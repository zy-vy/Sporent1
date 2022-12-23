import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemPrice extends StatelessWidget {

  const ItemPrice({Key? key, this.price, this.textStyle, this.trail}) : super(key: key);

  final TextStyle? textStyle;

  // final double? fontSize;

  final int? price;

  final bool? trail;

  @override
  Widget build(BuildContext context) {
    var fontSize = textStyle?.fontSize;
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: 0
    );

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("${currencyFormatter.format(price)}",style: textStyle,),
          Text(trail!=null? trail!?"/day":"":"",style: TextStyle(fontSize:( fontSize??14)*0.75)),
        ],
      ),
    );
  }
}
