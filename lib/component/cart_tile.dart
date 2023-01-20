import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/cart_detail_tile.dart';
import 'package:sporent/component/owner_thumbnail.dart';
import 'package:sporent/model/cart.dart';
import 'package:sporent/model/cart_detail.dart';

class CartTile extends StatelessWidget {
  final Cart cart;

  const CartTile({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: getCartDetailList(cart),
      builder: (context, snapshot) {
        if (!snapshot.hasData){
          // return const Center(child: CircularProgressIndicator());
        }
        var listCartDetail = snapshot.data;
        return Card(
          child: Column(
            children: [
              SizedBox(height: size.width/30,),
              OwnerThumbnail(userRef: cart.ownerRef!.path),
              Divider(color: HexColor("E0E0E0"),thickness: 2),
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
  Stream<List<CartDetail?>> getCartDetailList(Cart cart) async* {
    // Stream<List<Cart?>> stream= const Stream.empty();
    var firestore = FirebaseFirestore.instance;

    Stream<List<CartDetail?>> listCart = firestore
        .collection(CartDetail.path)
        .where("cart", isEqualTo: cart.toReference())
        .snapshots()
        .map((snapshot) {
      return CartDetail.fromSnapshot(snapshot.docs);
    });

    yield* listCart;
    // return stream;
  }


}