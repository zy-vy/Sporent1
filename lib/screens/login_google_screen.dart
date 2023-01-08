import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sporent/controller/auth_controller.dart';

class LoginGoogleScreen extends StatefulWidget {
  const LoginGoogleScreen({Key? key}) : super(key: key);

  @override
  State<LoginGoogleScreen> createState() => _LoginGoogleScreenState();
}

class _LoginGoogleScreenState extends State<LoginGoogleScreen> {

  AuthController authController= AuthController();

  Future<void> signIn() async {
    if (FirebaseAuth.instance.currentUser == null) {
      GoogleSignInAccount? account = await GoogleSignIn().signIn();

      if (account != null) {
        log("+++ ${account.email}");
        GoogleSignInAuthentication auth = await account.authentication;
        OAuthCredential credential = GoogleAuthProvider. credential(
            accessToken: auth.accessToken, idToken: auth.idToken);
        await FirebaseAuth.instance.signInWithCredential(credential);
      }
    }
    else{
      GoogleSignIn().signOut();
      FirebaseAuth.instance.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Current User:"),
            StreamBuilder<User?>(
                stream: FirebaseAuth.instance.userChanges(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text("no current user");
                  }
                  return Text(
                      "Signed in as ${FirebaseAuth.instance.currentUser!.displayName} (${FirebaseAuth.instance.currentUser!.email})");
                }),
            StreamBuilder<User?>(
                stream: FirebaseAuth.instance.userChanges(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return ElevatedButton(onPressed: () {
                      authController.signIn();
                    }, child: const Text("login"));
                  }
                  return ElevatedButton(onPressed: () {
                    authController.signOut();
                  }, child: const Text("logout"));
                })
          ],
        ),
      ),
    );
  }
}