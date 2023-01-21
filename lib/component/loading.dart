import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
        color: Colors.white,
        child: Center(
          child: SpinKitChasingDots(
            color: HexColor("4164DE"),
            size: 50,
          ),
        ));
  }
}
