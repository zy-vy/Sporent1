import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sporent/model/product.dart';
import 'package:sporent/screens/admin_order_screen.dart';

import '../component/firebase_image.dart';
import '../model/order.dart';

class ManagePaymentAdmin extends StatelessWidget {
  const ManagePaymentAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var firestore = FirebaseFirestore.instance;
    var size = MediaQuery.of(context).size.width;
    var dateFormat = DateFormat('d MMMM ' 'yyyy');
    NumberFormat currencyFormatter =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Manage Payment"),
          ),
          backgroundColor: HexColor("4164DE"),
        ),
        body: StreamBuilder(
            stream: firestore
                .collection("transaction")
                .where("status", isEqualTo: "WAITING")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              else if (snapshot.data!.docs.isEmpty){
                return const Center(child: Text("No Active Transaction"));
              }
              var orderList = Order.fromSnapshot(snapshot.data!.docs);
              return ListView.builder(
                shrinkWrap: true,
                itemCount: orderList.length,
                itemBuilder: (context, index) {

                  var order = orderList[index];
                  return FutureBuilder(
                    future: firestore.doc(order.productRef!.path).get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center();
                      }
                      order.product = Product.fromDocument(snapshot.data!.id, snapshot.data!.data()as Map<String,dynamic>);
                      return Container(
                          margin: EdgeInsets.symmetric(vertical: size/15,horizontal: size/15),
                          decoration: BoxDecoration(color: HexColor("F5F5F5")),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AdminOrderScreen(order: order)));
                            },
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: size / 20,
                                    horizontal: size/ 20),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: size/ 3,
                                      height: size / 3,
                                      child: FirebaseImage(
                                          filePath: "product-images/${order.product?.img}"),
                                    ),
                                    SizedBox(width:size / 25),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(dateFormat.format(order.startDate!),
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.normal)),
                                            SizedBox(height: size /30),
                                            Text("${order.product?.name}",
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold)),
                                            SizedBox(height: size/30),
                                            Text('Status : ${order.status}',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: HexColor("416DDE"),
                                                    fontWeight: FontWeight.bold)),
                                            SizedBox(height: size/30),
                                            Text('Total Payment : ${currencyFormatter.format(order?.total)}',
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500))
                                          ],
                                        )),
                                    SizedBox(width: size/20),
                                  ],
                                )),
                          ));
                  },);
                },
              );
            }));
  }
}
