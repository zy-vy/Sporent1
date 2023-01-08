

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sporent/component/cart_tile.dart';
import 'package:sporent/controller/test_user.dart';
import 'package:sporent/model/cart.dart';

class CartList extends StatelessWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getCartList(),
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
            return CartTile(cart: listCart[index]);
          },),
        );

    },);
  }
  Stream<List<Cart>?> getCartList() async* {

    var firestore = FirebaseFirestore.instance;

    var userRef = await TestUser().getUser()
        .then((value) => value?.toReference());

    Stream<List<Cart>?> listCart = firestore
        .collection(Cart.path)
        .where("user", isEqualTo: userRef)
        .snapshots()
        .map((value) {
      var listCart = Cart.fromSnapshot(value.docs);

      return listCart;
    });

    yield* listCart;
  }
}
