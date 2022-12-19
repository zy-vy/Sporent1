import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sporent/component/cart_detail_tile.dart';
import 'package:sporent/component/owner_thumbnail.dart';
import 'package:sporent/controller/cart_controller.dart';
import 'package:sporent/model/cart.dart';
import 'package:sporent/model/user.dart';

class CartTile extends StatelessWidget {
  final Cart cart;

  const CartTile({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: CartController().getCartDetailList(cart),
      builder: (context, snapshot) {
        if (!snapshot.hasData){
          // return const Center(child: CircularProgressIndicator());
        }
        var listCartDetail = snapshot.data;
        return Card(
          elevation: 1,
          child: Column(
            children: [
              OwnerThumbnail(userRef: cart.ownerRef!.path),
              ListView.builder(
                itemCount: listCartDetail?.length??0,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                // return Text("data1");
                return CartDetailTile(cartDetail: listCartDetail![index]!);
              },)
            ],
          ),
        );
      },
    );
  }
}