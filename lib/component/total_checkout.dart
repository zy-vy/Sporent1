import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sporent/controller/cart_controller.dart';
import 'package:sporent/model/cart.dart';
import 'package:sporent/model/cart_detail.dart';
import 'package:sporent/util/provider/cart_notifier.dart';

import 'package:sporent/util/provider/total_price.dart';
import 'package:sporent/viewmodel/cart_viewmodel.dart';

import '../screens/checkout.dart';
import 'item_price.dart';

class TotalCheckout extends StatefulWidget {
  const TotalCheckout({Key? key}) : super(key: key);

  @override
  State<TotalCheckout> createState() => _TotalCheckoutState();
}

class _TotalCheckoutState extends State<TotalCheckout> {
  @override
  Widget build(BuildContext context) {
    // final notifier = Provider.of<CartNotifier>(context,listen: true);

    Size size = MediaQuery.of(context).size;

    return Consumer<CartViewModel>(
        builder: (context, cartViewModel, child) => Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                        child: Text("Total: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20))),
                    ItemPrice(price: cartViewModel.totalAmount)
                  ],
                ),
                SizedBox(height: size.height / 30),
                SizedBox(
                  width: size.width,
                  height: size.height / 13,
                  child: cartViewModel.isLoading
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: HexColor("e0e0e0"),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                          onPressed: () {},
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ))
                      :
                      cartViewModel.listCart!.isEmpty
                          ?ElevatedButton(

                          style: ElevatedButton.styleFrom(
                              backgroundColor: HexColor("e0e0e0"),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                          onPressed: () {},

                          child: const Text("Checkout",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)))
                          :
                      // Future.delayed(, () => setState(() { ... }));
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: HexColor("4164DE"),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                          onPressed: () async {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => ChangeNotifierProvider(
                            //           create: (context) => cartViewModel,
                            //           builder: (context, child) => CheckoutPage(
                            //             totalAmount: cartViewModel.totalAmount,
                            //           ),
                            //         )));
                            int totalDeposit=0, totalPrice =0;
                            var cartList = cartViewModel.listCart;
                            for ( Cart cart in cartList!){
                              var listCartDetail = cart.listCartDetail!;
                              for ( CartDetail cartDetail in listCartDetail){
                                await FirebaseFirestore.instance
                                    .doc(cartDetail.productRef!.path)
                                    .get().then((value) {
                                        totalPrice +=
                                            (value.get("rent_price") as int) *
                                                cartDetail.quantity!;
                                        totalDeposit +=
                                        value.get("deposit_price") as int;
                                });
                              }
                            }
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutPage(totalAmount: cartViewModel.totalAmount, cartList: cartViewModel.listCart!, totalPrice: totalPrice, totalDeposit : totalDeposit),)).then((value) => cartViewModel.fetchData());
                          },
                          child: const Text("Checkout",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18))),
                )
              ],
              // ),
            ));
  }
}
