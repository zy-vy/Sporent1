import 'package:flutter/material.dart';

class ItemTitle extends StatelessWidget {
  const ItemTitle(
      {Key? key,
      required this.text,
      this.fontSize,
      this.maxLines,
      this.textOverflow, this.fontweight})
      : super(key: key);

  final String text;

  final double? fontSize;

  final int? maxLines;

  final TextOverflow? textOverflow;

  final FontWeight? fontweight;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontWeight: fontweight,
            fontSize: fontSize,
            color: Colors.black87),
        maxLines: maxLines,
        overflow: textOverflow,
        textAlign: TextAlign.justify);
  }
}
