
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sporent/component/cart_tile.dart';
import 'package:sporent/controller/cart_controller.dart';
import 'package:sporent/viewmodel/user_viewmodel.dart';

import '../component/total_checkout.dart';

class CartList extends StatelessWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context,listen: false).user!;
    var cartController = CartController();
    return StreamBuilder(
      stream: cartController.getCartList(user),
      builder: (context, snapshot) {

        if (!snapshot.hasData){
          return const Center(child: CircularProgressIndicator());
        }
        else if(snapshot.data!.isEmpty) {
          return const Center(child: Text("Your cart is Empty"));
        }
        var listCart = snapshot.data;
        return Container(
          height: double.infinity,
          child: ListView.builder(

            itemCount: listCart!.length,
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            shrinkWrap: true,
            itemBuilder: (context, index) {
            // return Text("data");
            return
              CartTile(cart: listCart[index]);
              // Text("cart : ${listCart[index].listCartDetail?[0]}");
          },),
        );

    },);
  }
}
