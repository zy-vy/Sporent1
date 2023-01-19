import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sporent/component/item_price.dart';
import 'package:sporent/model/order.dart';
import 'package:sporent/screens/order_detail_screen.dart';
import 'package:sporent/viewmodel/order_viewmodel.dart';
import 'package:sporent/viewmodel/user_viewmodel.dart';

import '../component/firebase_image.dart';
import '../utils/colors.dart';

class ManageOrderScreen extends StatelessWidget {
  const ManageOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    var dateFormat = DateFormat('d MMMM ' 'yyyy');
    NumberFormat currencyFormatter =
    NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
    return Consumer<UserViewModel>(builder: (context, userViewModel, child) => Consumer<OrderViewModel>(
      builder: (context, orderViewModel, child) => Scaffold(
        body: StreamBuilder(
          stream: orderViewModel.getAllOrderByOwner(userViewModel.user!.id!),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Center(child: CircularProgressIndicator()),
              );
            }
            else if (snapshot.data!.isEmpty){
              return const Center(child: Text("No Active Order"));
            }

            // var orderList = snapshot.data;
            var orderList = orderViewModel.orderList;

            return ListView.builder(
              itemCount: orderList!.length,
              itemBuilder: (context, index) {
                Order? order = orderList[index];
                return FutureBuilder(
                    future: orderViewModel.fetchData(order),
                    builder: (context, snapshot) {
                      order = snapshot.data;
                      if (order == null) {
                        return const Center();
                      }
                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.symmetric(
                            horizontal: size / 20, vertical: size / 50),
                        child: Container(
                            decoration:
                            BoxDecoration(color: hexStringToColor("F5F5F5")),
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
                                          filePath: "product-images/${order?.product?.imageFile}"),
                                    ),
                                    SizedBox(width:size / 60),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(dateFormat.format(order!.startDate!),
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.normal)),
                                            SizedBox(height: size /30),
                                            Text("${order?.product?.name}",
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold)),
                                            SizedBox(height: size/30),
                                            Text('Status : ${order?.status}',
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
                                )))
                      );
                    });
                // if(order.product!=null){
                //
                // else {
                //   return const Center(child: CircularProgressIndicator(),);
                // }
              },
            );
          },
        ),
      ),
    ));
  }
}
