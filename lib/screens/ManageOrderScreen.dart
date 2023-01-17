import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sporent/component/item_price.dart';
import 'package:sporent/model/order.dart';
import 'package:sporent/screens/order_detail_screen.dart';
import 'package:sporent/viewmodel/order_viewmodel.dart';

class ManageOrderScreen extends StatelessWidget {
  const ManageOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Consumer<OrderViewModel>(
      builder: (context, orderViewModel, child) => Scaffold(
        body: StreamBuilder(
          stream: orderViewModel.getAllOrderByOwner("gqDM311gkUykkJqRnPdY"),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
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
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.symmetric(
                            horizontal: size / 20, vertical: size / 50),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>OrderDetailScreen(order: order!)));
                          },
                          leading: AspectRatio(
                              aspectRatio: 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.file(order!.product!.imageFile!,
                                    fit: BoxFit.scaleDown),
                              )),
                          title: Text(order?.product?.name ?? "",maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                              ItemPrice(price: order?.product?.rentPrice,trail: true,),
                              Text("Time: ${order?.quantity}",overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,),
                              Text("status: ${order?.status?.toLowerCase()}",style: TextStyle(color: HexColor("416DDE")),overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,),
                            ]),
                          ),
                          trailing:
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(IconlyLight.activity,size: 20,),
                            ],
                          )

                        ),
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
    );
  }
}
