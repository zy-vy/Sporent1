import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sporent/component/bar-profile.dart';
import 'package:sporent/component/no_current_user.dart';
import 'package:sporent/screens/change-password.dart';
import 'package:sporent/screens/deposit-information.dart';
import 'package:sporent/screens/manage_balance_admin.dart';
import 'package:sporent/screens/profile.dart';
import 'package:sporent/screens/signin_screen.dart';

import '../viewmodel/user_viewmodel.dart';

class AdminProfile extends StatelessWidget {
  const AdminProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Padding(
              padding: EdgeInsets.only(top: _size.height / 16),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: const NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/sporent-80b28.appspot.com/o/admin.png?alt=media&token=b6d2928e-4cf6-4eef-b108-97b38c5b17f1"),
                    radius: 100,
                  ),
                  nameProfile(_size, "Admin"),
                  const BarProfile("Manage Balance", "Show all request balance",
                      FontAwesomeIcons.coins, ManageBalance()),
                  const BarProfile(
                      "Manage Complain",
                      "Show all complain product",
                      FontAwesomeIcons.circleQuestion,
                      EditPassword()),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: _size.height / 50),
                    child: TextButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignInScreen()));
                        },
                        child: Text("Log Out",
                            style: TextStyle(
                                color: HexColor("DE4141"),
                                fontWeight: FontWeight.bold,
                                fontSize: 18))),
                  )
                ],
              ))),
    );
  }
}
