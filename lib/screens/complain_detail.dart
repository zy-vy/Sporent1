import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sporent/model/complain_detail.dart';
import 'package:sporent/screens/complain_feedback.dart';
import 'package:sporent/screens/finish_complain.dart';

import '../component/complain_card.dart';
import '../component/transaction_card_detail.dart';
import '../model/complain.dart';

class DetailComplain extends StatelessWidget {
  const DetailComplain(
      this.id, this.product_name, this.product_image, this.total, this.role,
      {super.key, this.idUser, this.idOwner, this.idTransaction});

  final String id;
  final String product_name;
  final String product_image;
  final int total;
  final String role;
  final String? idUser;
  final String? idOwner;
  final String? idTransaction;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    var dateFormat = DateFormat('d MMMM ' 'yyyy');
    NumberFormat currencyFormatter =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Complain Detail"),
          ),
          backgroundColor: HexColor("4164DE"),
        ),
        body: Padding(
          padding: EdgeInsets.only(
              top: _size.height / 40,
              bottom: _size.height / 20,
              left: _size.width / 18,
              right: _size.width / 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: StreamBuilder(
                stream: firestore.collection("complain").doc(id).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Status: ${snapshot.data!.get("status")}",
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600)),
                        SizedBox(height: _size.height / 70),
                        Divider(color: HexColor("E0E0E0"), thickness: 2),
                        SizedBox(height: _size.height / 70),
                        DetailTransactionCard(18, 16, 15, 18, "Total Payment",
                            product_image, product_name, total),
                        SizedBox(height: _size.height / 50),
                        Divider(color: HexColor("E0E0E0"), thickness: 2),
                        SizedBox(height: _size.height / 70),
                        const Text(
                          "Complain",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        StreamBuilder(
                            stream: firestore
                                .collection("complain_detail")
                                .where("complain",
                                    isEqualTo: firestore
                                        .collection("complain")
                                        .doc(id))
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      ComplainDetail complainDetail =
                                          ComplainDetail.fromDocument(
                                              snapshot.data!.docs[index].id,
                                              snapshot.data!.docs[index]
                                                  .data());
                                      bool line = false;

                                      if (index != 0) {
                                        line = true;
                                      }
                                      return ComplainCard(
                                          complainDetail.image!,
                                          complainDetail.description!,
                                          dateFormat
                                              .format(complainDetail.date!),
                                          line);
                                    });
                              }
                            }),
                        SizedBox(height: _size.height / 20),
                        SizedBox(
                            width: _size.width,
                            height: _size.height / 12,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ComplainFeedback(id)),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: HexColor("4164DE"),
                              ),
                              child: const Text("Give Complain Feedback",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  textAlign: TextAlign.center),
                            )),
                        SizedBox(height: _size.height / 30),
                        role == "admin"
                            ? Center(
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FinishComplain(idTransaction!,id ,idUser!, idOwner!)));
                                    },
                                    child: Text(
                                      "Finish Complain",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: HexColor("4164DE"),
                                          fontWeight: FontWeight.bold),
                                    )),
                              )
                            : const SizedBox(),
                      ],
                    );
                  }
                }),
          ),
        ));
  }
}
