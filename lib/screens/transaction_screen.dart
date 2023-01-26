import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sporent/utils/colors.dart';
import '../component/loading.dart';
import '../component/no_current_user.dart';
import '../component/transaction_card.dart';
import '../model/user.dart';
import '../repository/user_repository.dart';
import '../model/transaction.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreen();
}

class _TransactionScreen extends State<TransactionScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final _userRepository = UserRepository();
  UserLocal? user;
  bool isLoggedIn = false;
  bool isLoading = true;
  int counter = 0;

  Future fetchUser() async {
    await Future.delayed(const Duration(seconds: 1));
    if (FirebaseAuth.instance.currentUser != null) {
      user = await _userRepository
          .getUserById(FirebaseAuth.instance.currentUser!.uid);
      setState(()  {
          isLoggedIn = true;
          isLoading = false;
          counter = 1;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    counter == 0 ? fetchUser() : counter;

    return isLoading
        ? const Loading()
        : isLoggedIn
            ? Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Padding(
                    padding: EdgeInsets.only(top: _size.height / 80),
                    child: const Text(
                      "Transaction",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.white,
                ),
                resizeToAvoidBottomInset: false,
                backgroundColor: hexStringToColor("ffffff"),
                body: Padding(
                    padding: EdgeInsets.only(
                        right: _size.width / 30,
                        left: _size.width / 30,
                        bottom: _size.height / 40),
                    child: StreamBuilder(
                        stream: firestore
                            .collection("transaction")
                            .where("user",
                                isEqualTo:
                                    firestore.collection("user").doc(user!.id)).orderBy('issue_date')
                            .snapshots(),
                        builder: ((context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: ((context, index) {
                                  TransactionModel transaction =
                                      TransactionModel.fromDocument(
                                          snapshot.data!.docs[index].id,
                                          snapshot.data!.docs[index].data());
                                  return TransactionCard(transaction, user!.id);
                                }));
                          }
                        }))))
            : const NoCurrentUser();
  }
}
