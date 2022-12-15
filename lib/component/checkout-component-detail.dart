import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class DetailCheckout extends StatelessWidget {
  const DetailCheckout(this.title, this.detailTitle, this.detailDesc, this.icon,
      this.haveDesc,
      {super.key});

  final String title;
  final String detailTitle;
  final String detailDesc;
  final IconData? icon;
  final bool haveDesc;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: _size.height / 30),
        Text(
          title,
          style: const TextStyle(
              fontSize: 23, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: _size.height / 70),
        Row(
          children: [
            Container(
              width: _size.width / 6,
              height: _size.height / 13,
              decoration: BoxDecoration(
                color: HexColor("8DA6FE"),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: FaIcon(icon, color: Colors.white, size: 30)),
            ),
            SizedBox(width: _size.width / 40),
            haveDesc == true
                ? expandTextHaveDesc(detailTitle, detailDesc, _size)
                : expandTextNotHaveDesc(detailTitle),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.keyboard_arrow_right_outlined,
                    color: Colors.black, size: 40))
          ],
        ),
      ],
    );
  }
}

Expanded expandTextHaveDesc(
        String detailTitle, String detailDesc, Size _size) =>
    Expanded(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Text(detailTitle,
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
          SizedBox(height: _size.height / 80),
          Text(detailDesc,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
              overflow: TextOverflow.ellipsis)
        ]));

Expanded expandTextNotHaveDesc(String detailTitle) => Expanded(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Text(detailTitle,
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        ]));

Row textHaveDetail(Size _size, bool haveDesc, IconData icon, String detailTitle,
        String detailDesc) =>
    Row(
      children: [
        Container(
          width: _size.width / 6,
          height: _size.height / 13,
          decoration: BoxDecoration(
            color: HexColor("8DA6FE"),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: FaIcon(icon, color: Colors.white, size: 30)),
        ),
        SizedBox(width: _size.width / 40),
        haveDesc == true
            ? expandTextHaveDesc(detailTitle, detailDesc, _size)
            : expandTextNotHaveDesc(detailTitle),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.keyboard_arrow_right_outlined,
                color: Colors.black, size: 40))
      ],
    );
