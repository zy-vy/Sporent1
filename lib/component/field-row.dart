import 'package:flutter/material.dart';

class FieldRow extends StatelessWidget {
  const FieldRow(
      this.title, this.desc, this.expandedOrNot, this.fontSize, this.fontWeightTitle, this.fontWeightDesc, 
      {super.key});

  final String title;
  final String desc;
  final bool expandedOrNot;
  final double? fontSize;
  final FontWeight fontWeightTitle;
  final FontWeight fontWeightDesc;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Text(
              title,
              style: TextStyle(fontSize: fontSize, fontWeight: fontWeightTitle),
            )),
            expandedOrNot == true
                ? Expanded(
                    child: Text(
                    desc,
                    style:
                        TextStyle(fontSize: fontSize, fontWeight: fontWeightDesc),
                  ))
                : Text(
                    desc,
                    style:
                        TextStyle(fontSize: fontSize, fontWeight: fontWeightDesc),
                  )
          ],
        ),
        SizedBox(height: _size.height / 40),
      ],
    );
  }
}
