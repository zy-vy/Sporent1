import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:sporent/screens/cart_screen.dart';
import 'package:sporent/screens/home_screen.dart';
import 'package:sporent/screens/profile_screen.dart';
import 'package:sporent/screens/transaction_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
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
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              label: 'Home',
              icon: ImageIcon(AssetImage("assets/images/Home Before.png")),
              activeIcon: ImageIcon(AssetImage("assets/images/Home After.png"))),
          BottomNavigationBarItem(
              label: 'Transaction',
              icon: ImageIcon(AssetImage("assets/images/Transaction Before.png")),
              activeIcon:
              ImageIcon(AssetImage("assets/images/Transaction After.png"))),
          BottomNavigationBarItem(
              label: 'Cart',
              icon: ImageIcon(AssetImage("assets/images/Cart Before.png")),
              activeIcon: ImageIcon(AssetImage("assets/images/Cart After.png"))),
          BottomNavigationBarItem(
              label: 'Profile',
              icon: ImageIcon(AssetImage("assets/images/Profile Before.png")),
              activeIcon: ImageIcon(AssetImage("assets/images/Profile After.png")))
        ],
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIdx,
        onTap: (int index) {
          setState(() {
            _selectedIdx = index;
          });
        },
      ),
    );
  }
}
