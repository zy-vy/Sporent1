import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/cart-card.dart';
import 'package:sporent/screens/bottom_bar.dart';
import 'package:sporent/screens/checkout.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPage();
}

class _CartPage extends State<CartPage> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(top: _size.height / 80),
          child: const Text(
            "Cart",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: _size.height / 30, horizontal: _size.width / 13),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: const [CartCard(true), CartCard(false)],
              ),
            ),
            Divider(thickness: 1, color: HexColor("A3A3A3")),
            SizedBox(height: _size.height / 80),
            Row(
              children: const [
                Expanded(
                    child: Text("Total: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20))),
                Text("Rp 300.000",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
              ],
            ),
            SizedBox(height: _size.height / 30),
            SizedBox(
              width: _size.width,
              height: _size.height / 13,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor("4164DE")),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const BottomBarScreen()));
                  },
                  child: const Text("Checkout",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18))),
            )
          ],
        ),
      ),
    );
  }
}
