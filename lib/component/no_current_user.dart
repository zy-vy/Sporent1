import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sporent/screens/signin_screen.dart';

class NoCurrentUser extends StatelessWidget {
  const NoCurrentUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("You have not sign in yet..."),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen(),));
            }, child:const Text("Log in here."),),


          ],
        ),
      ),
    );
  }
}
