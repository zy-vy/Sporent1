import 'package:flutter/material.dart';
import 'package:sporent/screens/cart_list.dart';

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
              const CartList())
      // )
      ,
    )));
  }
}
