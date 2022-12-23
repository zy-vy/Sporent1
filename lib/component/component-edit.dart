import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class FieldForm extends StatelessWidget {
  const FieldForm(this.title, this.desc, this.page, this.fontSizeTitle,
      this.fontSizeDesc, this.sizeSizedBox, this.haveData,
      {super.key});

  final String title;
  final String desc;
  final Widget page;
  final double fontSizeTitle;
  final double fontSizeDesc;
  final double sizeSizedBox;
  final bool haveData;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Column(
      children: [
        Row(
          children: [
            Text(title,
                style: TextStyle(fontSize: fontSizeTitle, color: Colors.black)),
            SizedBox(width: _size.width / sizeSizedBox),
            haveData == true
                ? Expanded(
                    child: Text(desc,
                        style: TextStyle(
                            fontSize: fontSizeDesc,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)))
                : Expanded(
                    child: Text(desc,
                        style: TextStyle(fontSize: 12, color: HexColor("B0B0B0")))),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => page,
                  ),
                );
              },
              icon: const FaIcon(FontAwesomeIcons.chevronRight),
              iconSize: 20,
            ),
          ],
        ),
        SizedBox(height: _size.height / 70),
      ],
    );
  }
}
