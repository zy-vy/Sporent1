import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sporent/viewmodel/cart_viewmodel.dart';

import 'cart_detail_tile.dart';
import 'owner_thumbnail.dart';

class CartListTest extends StatefulWidget {
  const CartListTest({Key? key}) : super(key: key);

  @override
  State<CartListTest> createState() => _CartListTestState();
}

class _CartListTestState extends State<CartListTest> {
  
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<CartViewModel>(context,listen: false).fetchData();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(builder: (context, cartViewModel, child) {
      if (cartViewModel.isLoading){
        return const Center(child: CircularProgressIndicator(),);
      }
      var listCart = cartViewModel.listCart;
      final streamCart = StreamController<dynamic>();
      streamCart.add(listCart);
      return StreamBuilder<dynamic>(
        stream: streamCart.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }
          else if(snapshot.data!.isEmpty) {
            return const Center(child: Text("Your cart is Empty"));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var cart = snapshot.data[index];
              var listCartDetail = cart.listCartDetail;
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
            );;
          },);
        }
      );
    },);
  }
}
