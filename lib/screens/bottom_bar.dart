import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:sporent/screens/cart_screen.dart';
import 'package:sporent/screens/home_screen.dart';
import 'package:sporent/screens/profile_screen.dart';
import 'package:sporent/screens/transaction_screen.dart';

class ButtomBarScreen extends StatefulWidget {
  const ButtomBarScreen({Key? key}) : super(key: key);

  @override
  State<ButtomBarScreen> createState() => _ButtomBarScreenState();
}

class _ButtomBarScreenState extends State<ButtomBarScreen> {
  int _selectedIdx=0;
  final List pageList = [
    const HomeScreen(),
    const TransactionScreen(),
    const CartScreen(),
    const ProfileScreen()
  ];

  void selectedPage(int index){
    setState(() {
      _selectedIdx = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[_selectedIdx],
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.home),
              label: "Home"
            ),
            BottomNavigationBarItem(
                icon: Icon(IconlyLight.category),
                label: "Transaction"
            ),
          ]),
    );
  }
}
