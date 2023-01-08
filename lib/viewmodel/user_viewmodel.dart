import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sporent/model/user.dart';
import 'package:sporent/repository/user_repository.dart';

import '../controller/user_controller.dart';

class UserViewModel with ChangeNotifier{

  bool _isLoading = true;

  bool _isLoggedIn = false;

  UserLocal? _user;

  final _userRepository = UserRepository();

  final firebaseAuth = FirebaseAuth.instance;

  UserViewModel ( ){
    fetchUser();
  }

  UserLocal? get user {
    log("user viewmodel ${_user?.name}");
    if (firebaseAuth.currentUser == null){
      signIn();
    }
    fetchUser();
    return _user;
  }


  set user (UserLocal? user){
    _user = user;
    // notifyListeners();
  }

  Future<void> signIn() async {
    if (firebaseAuth.currentUser == null) {
      // GoogleSignInAccount? account = await GoogleSignIn().signIn();
      //
      // if (account != null) {
      //   log("+++ email ${account.email}",level: 1);
      //   GoogleSignInAuthentication auth = await account.authentication;
      //   OAuthCredential credential = GoogleAuthProvider. credential(
      //       accessToken: auth.accessToken, idToken: auth.idToken);
      //   await firebaseAuth.signInWithCredential(credential);
      //
      //
      // }
      isLoggedIn = false;
    }
    else {
      _user = await UserController().createUserFromAuth(firebaseAuth.currentUser!);
      isLoggedIn =true;

    }
    notifyListeners();
  }

  Future<void> fetchUser() async {
    isLoading=true;
    if (firebaseAuth.currentUser!=null){
      user = await _userRepository.getUserById(firebaseAuth.currentUser!.uid);
      isLoggedIn= true;
    }

    isLoading = false;
  }

  Future<void> signOut() async {
    if (_user !=null){
      await firebaseAuth.signOut().then((value) => log("User ${_user?.name} has sign out"));
      user=null;
      isLoggedIn=false;
      notifyListeners();
    }
  }


  set isLoading(bool value){
    _isLoading = value;
    // notifyListeners();
  }

  bool  get isLoggedIn {

    fetchUser();
    return _isLoggedIn;
  }

  set isLoggedIn (bool value){
    _isLoggedIn = value;
    // notifyListeners();
  }
}