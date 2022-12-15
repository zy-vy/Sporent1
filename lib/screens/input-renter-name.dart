import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/edit-page.dart';
import 'package:sporent/screens/profile-renter.dart';

class InputRenterName extends StatefulWidget {
  const InputRenterName({super.key});

  @override
  State<InputRenterName> createState() => _InputRenterNameState();
}

class _InputRenterNameState extends State<InputRenterName> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
          child: const Text("Input Renter Information"),
        ),
        backgroundColor: HexColor("4164DE"),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: _size.height / 30, horizontal: _size.width / 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topPage("Renter Name", _size, "Enter a unique name for your page"),
            fieldText("Enter your name", "Name"),
            bottomPage(_size, _formKey, context, const RenterProfile()),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text("Terms & Condition",
                        style: TextStyle(
                            color: HexColor("4164DE"),
                            fontWeight: FontWeight.w600,
                            fontSize: 16))),
                const Text("and",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16)),
                TextButton(
                    onPressed: () {},
                    child: Text("Privacy Policy",
                        style: TextStyle(
                            color: HexColor("4164DE"),
                            fontWeight: FontWeight.w600,
                            fontSize: 16))),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
