import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sporent/model/order.dart';
import 'package:sporent/viewmodel/order_viewmodel.dart';

class ManageOrderScreen extends StatelessWidget {
  const ManageOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => OrderViewModel(),
        )
      ],
      child: Consumer<OrderViewModel>(
        builder: (context, orderViewModel, child) => Scaffold(
          body: StreamBuilder(
            stream: orderViewModel.getAllOrderByOwner("gqDM311gkUykkJqRnPdY"),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              var orderList = snapshot.data;

              return ListView.builder(
                itemCount: orderList!.length,
                itemBuilder: (context, index) {
                  
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(horizontal: size/20,vertical: size/50),
                    child: ListTile(
                      title: Text(orderList[index].productRef?.path ?? ""),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
