import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sporent/controller/cart_controller.dart';
import 'package:sporent/model/cart.dart';
import 'package:sporent/util/provider/total_price.dart';

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
    // final totalPovider = Provider.of<TotalPriceProvider>(context,listen: true);

    Size size = MediaQuery.of(context).size;

    return

         Consumer<TotalPriceProvider>(
           builder : (context, totalPriceProvider, child) =>
               Column(
        children: [
          Row(
            children: [
              const Expanded(
                  child: Text("Total: ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20))),
              ItemPrice(price: totalPriceProvider.totalPrice)
            ],
          ),
          SizedBox(height: size.height / 30),
          SizedBox(
            width: size.width,
            height: size.height / 13,
            child:
                // snapshot.hasData?ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //         backgroundColor: HexColor("4164DE"),
                //         shape: const RoundedRectangleBorder(
                //             borderRadius:
                //             BorderRadius.all(Radius.circular(20)))),
                //     onPressed: () {
                //     },
                //     child: const Center(child: CircularProgressIndicator(),)
                //
                // ):
                // Future.delayed(, () => setState(() { ... }));
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("4164DE"),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CheckoutPage()));
                    },
                    child: const Text("Checkout",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18))),
          )
        ],
      ),
    );
  }
}
