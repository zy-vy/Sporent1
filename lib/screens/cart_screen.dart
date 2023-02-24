import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sporent/component/cart_list_test.dart';
import 'package:sporent/component/item_price.dart';
import 'package:sporent/component/no_current_user.dart';
import 'package:sporent/component/total_checkout.dart';
import 'package:sporent/screens/cart_list.dart';
import 'package:sporent/util/provider/cart_notifier.dart';
import 'package:sporent/util/provider/item_count.dart';
import 'package:sporent/util/provider/total_price.dart';
import 'package:sporent/viewmodel/cart_viewmodel.dart';
import 'package:sporent/viewmodel/user_viewmodel.dart';

import 'checkout.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool haveData = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<UserViewModel>(
        builder: (context, userViewModel, child) => userViewModel.isLoggedIn
            ? Scaffold(
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
                      margin: EdgeInsets.symmetric(
                          vertical: size.height / 100,
                          horizontal: size.width / 40),
                      padding: EdgeInsets.symmetric(
                          vertical: size.height / 100,
                          horizontal: size.width / 35),
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: RefreshIndicator(
                        onRefresh: () async {
                          // setState(() {});
                        },
                        child:
                            // SingleChildScrollView(
                            //     controller: ScrollController(),
                            //     physics: const ScrollPhysics(),
                            //     child:
                            MultiProvider(
                                providers: [
                              // ChangeNotifierProvider(
                              //     create: (context) => CartNotifier()),
                              ChangeNotifierProvider(
                                create: (context) => CartViewModel(),
                              ),
                            ],
                                child: Column(
                                    // mainAxisSize: MainAxisSize.max,
                                    children: [
                                      // Expanded(child: CartListTest()),
                                      const Expanded(child: CartList()),
                                      Divider(
                                          thickness: 1,
                                          color: HexColor("A3A3A3")),
                                      SizedBox(height: size.height / 30),
                                      haveData
                                          ? const TotalCheckout()
                                          : const SizedBox(),
                                    ])),
                      ))
                  // )
                  ,
                ))
            : const NoCurrentUser());
  }
}

