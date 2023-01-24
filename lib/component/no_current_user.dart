import 'package:flutter/material.dart';
import 'package:sporent/screens/signin_screen.dart';
import 'package:hexcolor/hexcolor.dart';

class NoCurrentUser extends StatelessWidget {
  const NoCurrentUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("You have not sign in yet..."),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInScreen(),
                    ));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor("4164DE")),
              child: const Text("Log in here.")),
        ],
      ),
    );
  }
}
