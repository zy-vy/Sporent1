import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:sporent/screens/login_google_screen.dart';
import 'package:sporent/screens/profile.dart';
import 'package:sporent/screens/cart_screen.dart';
import 'package:sporent/screens/cart.dart';
import 'package:sporent/screens/home_screen.dart';
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
    const ProfilePage()
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
              icon: ImageIcon(AssetImage("assets/icons/Home Before.png")),
              activeIcon: ImageIcon(AssetImage("assets/icons/Home After.png"))),
          BottomNavigationBarItem(
              label: 'Transaction',
              icon: ImageIcon(AssetImage("assets/icons/Transaction Before.png")),
              activeIcon: FaIcon(FontAwesomeIcons.receipt)),
          BottomNavigationBarItem(
              label: 'Cart',
              icon: ImageIcon(AssetImage("assets/icons/Cart Before.png")),
              activeIcon: ImageIcon(AssetImage("assets/icons/Cart After.png"))),
          BottomNavigationBarItem(
              label: 'Profile',
              icon: ImageIcon(AssetImage("assets/icons/Profile Before.png")),
              activeIcon: ImageIcon(AssetImage("assets/icons/Profile After.png")))
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
