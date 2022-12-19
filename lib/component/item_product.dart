import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  final String _text;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width / 20, vertical: size.width / 35),
            child: Text(_text,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 23,
                    color: Colors.black87),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center)),
      ],
    );
  }
}
