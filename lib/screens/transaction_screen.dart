import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sporent/utils/colors.dart';

import '../component/no_current_user.dart';
import '../component/transaction_card.dart';
import '../viewmodel/user_viewmodel.dart';
import '../model/transaction.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreen();
}

class _TransactionScreen extends State<TransactionScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
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
            padding: EdgeInsets.only(right: _size.width/30, left: _size.width/30, bottom: _size.height/40),
            child: Consumer<UserViewModel>(
                builder: (context, userViewModel, child) => userViewModel
                        .isLoggedIn
                    ? StreamBuilder(
                        stream: firestore
                            .collection("transaction")
                            .where("user",
                                isEqualTo: firestore
                                    .collection("user")
                                    .doc(userViewModel.user!.id))
                            .snapshots(),
                        builder: ((context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                                  return TransactionCard(transaction);
                                }));
                          }
                        }))
                    : const NoCurrentUser())));
  }
}
