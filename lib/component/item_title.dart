import 'package:flutter/material.dart';

class ItemTitle extends StatelessWidget {
  const ItemTitle({Key? key,required String text}) : _text = text, super(key: key);

  final String _text;
  
  @override
  Widget build(BuildContext context) {
    return Text(_text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26,color: Colors.black87),maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,);
  }
}
