import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sporent/component/firebase_image.dart';
import 'package:sporent/model/transaction.dart';
import 'package:sporent/screens/complain_product.dart';
import 'package:sporent/screens/transaction_detail.dart';
import 'package:sporent/utils/colors.dart';

import '../screens/return_product.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard(this.transaction, this.idUser, {super.key});

  final TransactionModel transaction;
  final String? idUser;

  @override
  Widget build(BuildContext context) {
    Reference firebase = FirebaseStorage.instance.ref();
    Size _size = MediaQuery.of(context).size;
    var dateFormat = DateFormat('d MMMM ' 'yyyy');
    NumberFormat currencyFormatter =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

    return Padding(
        padding: EdgeInsets.symmetric(vertical: _size.height / 50),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("product")
                .doc(
                  transaction.product!.id.replaceAll(")", ''),
                )
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var image = snapshot.data!.get('img');
                var name = snapshot.data!.get('name');
                return TextButton(
                    onPressed: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailTransaction(
                                  transaction.id!,
                                  image,
                                  name,
                                  snapshot.data!.id,
                                  idUser!)));
                    }),
                    child: Container(
                        decoration:
                            BoxDecoration(color: hexStringToColor("F5F5F5")),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: _size.width / 20,
                                horizontal: _size.height / 50),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: _size.width / 3,
                                  height: _size.height / 7,
                                  child: FirebaseImage(
                                      filePath: "product-images/$image"),
                                ),
                                SizedBox(width: _size.width / 60),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        dateFormat
                                            .format(transaction.start_date!),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal)),
                                    SizedBox(height: _size.height / 70),
                                    Text(name,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: _size.height / 70),
                                    Text('Status : ${transaction.status}',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: HexColor("416DDE"),
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: _size.height / 70),
                                    Text(
                                        'Total Payment : ${currencyFormatter.format(transaction.total)}',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500))
                                  ],
                                )),
                                SizedBox(width: _size.width / 40),
                              ],
                            ))));
              }
            }));
  }
}
