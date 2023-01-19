import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sporent/screens/signin_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text("Log Out"),
        onPressed: () {
          FirebaseAuth.instance.signOut().then((value) {
            print("Sign Out Success");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignInScreen()));
          });
        },
      ),
    );
  }
}
