import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sporent/model/complain_detail.dart';
import 'package:sporent/screens/complain_feedback.dart';
import 'package:sporent/screens/finish_complain.dart';

import '../component/complain_card.dart';
import '../component/transaction_card_detail.dart';
import '../model/complain.dart';

class DetailComplain extends StatefulWidget {
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
  State<DetailComplain> createState() => _DetailComplainState();
}

class _DetailComplainState extends State<DetailComplain> {
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
                stream:
                    firestore.collection("complain").doc(widget.id).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    Complain complain = const Complain(id: "");
                    complain = Complain.fromDocument(
                        snapshot.data!.id, snapshot.data!.data()!, false);
                    if (snapshot.data!.data()!.containsKey("date")) {
                      complain = Complain.fromDocument(
                          snapshot.data!.id, snapshot.data!.data()!, true);
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Status: ${complain.status}",
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600)),
                        SizedBox(height: _size.height / 70),
                        complain.status != "In Progress"
                            ? Text("Date: ${dateFormat.format(complain.date!)}",
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600))
                            : const SizedBox(),
                        complain.status != "In Progress"
                            ? SizedBox(height: _size.height / 70)
                            : const SizedBox(),
                        Divider(color: HexColor("E0E0E0"), thickness: 2),
                        SizedBox(height: _size.height / 70),
                        DetailTransactionCard(
                            18,
                            16,
                            15,
                            18,
                            "Total Payment",
                            widget.product_image,
                            widget.product_name,
                            widget.total),
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
                                        .doc(widget.id))
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
                        complain.status != "In Progress"
                            ? Text("Conclusion: ${complain.conclusion}",
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600))
                            : SizedBox(
                                width: _size.width,
                                height: _size.height / 12,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ComplainFeedback(widget.id)),
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
                        widget.role == "admin"
                            ? complain.status != "In Progress"
                                ? SizedBox()
                                : Center(
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FinishComplain(
                                                          widget.idTransaction!,
                                                          widget.id)));
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
