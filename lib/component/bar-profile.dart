import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BarProfile extends StatelessWidget {
  const BarProfile(this.title, this.desc, this.image, this.page, {super.key});

  final String title;
  final String desc;
  final IconData image;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
          left: _size.width / 8,
          right: _size.width / 15,
          top: _size.height / 60),
      child: Container(
        height: 70,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.4, color: Colors.grey))),
        child: TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => page,
                ),
              );
            },
            child: Row(
              children: [
                FaIcon(image, color: Colors.black),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: _size.width / 15, right: _size.width / 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20)),
                        Text(desc,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_right_outlined,
                    color: Colors.black, size: 40)
              ],
            )),
      ),
    );
  }
}
