import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sporent/controller/user_controller.dart';
import 'package:sporent/model/user.dart';

class AuthController {
  static final AuthController _instance = AuthController._internal();

  factory AuthController(){
    return _instance;
  }

  AuthController._internal();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final userController = UserController();
  UserLocal? _userLocal;


  Future<UserLocal?> getCurrentUser() async {
    if (_userLocal==null){
      await signIn();
    }
    return _userLocal;
  }


  Future<void> signOut() async {
    GoogleSignIn().signOut();
    firebaseAuth.signOut();

  }


  Future<void> signIn() async {
    if (firebaseAuth.currentUser == null) {
      GoogleSignInAccount? account = await GoogleSignIn().signIn();

      if (account != null) {
        // log("+++ email ${account.email}",level: 1);
        GoogleSignInAuthentication auth = await account.authentication;
        OAuthCredential credential = GoogleAuthProvider. credential(
            accessToken: auth.accessToken, idToken: auth.idToken);
        await firebaseAuth.signInWithCredential(credential);


      }
    }
    _userLocal = await userController.createUserFromAuth(firebaseAuth.currentUser!);
  }

//error modal

}