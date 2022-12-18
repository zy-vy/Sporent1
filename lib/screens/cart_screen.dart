import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sporent/component/item_price.dart';
import 'package:sporent/component/total_checkout.dart';
import 'package:sporent/screens/cart_list.dart';
import 'package:sporent/util/provider/item_count.dart';
import 'package:sporent/util/provider/total_price.dart';

import 'checkout.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.only(top: size.height / 80),
            child: const Text(
              "Cart",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Center(
            child: Container(
          margin: EdgeInsets.symmetric(vertical: size.height / 100),
          padding: EdgeInsets.symmetric(vertical: size.height / 100),
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
          ),
          child: RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              child:
                  // SingleChildScrollView(
                  //     controller: ScrollController(),
                  //     physics: const ScrollPhysics(),
                  //     child:
                  MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                      create: (context) => TotalPriceProvider()),
                  ChangeNotifierProvider(
                      create: (context) => ItemCountProvider())
                ],
                child: Column(
                  children: [
                    const Expanded(child: CartList()),
                    Divider(thickness: 1, color: HexColor("A3A3A3")),
                    SizedBox(height: size.height / 30),
                    Column(
                      children: [
                        Row(
                          children: [
                            const Expanded(
                                child: Text("Total: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20))),
                            const Text("Rp. 20"),
                          ],
                        ),
                        SizedBox(height: size.height / 30),
                        SizedBox(
                          width: size.width,
                          height: size.height / 13,
                          child:
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
                  ],
                ),
              ))
          // )
          ,
        )));
  }
}
