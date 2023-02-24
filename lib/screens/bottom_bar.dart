import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:sporent/screens/profile.dart';
import 'package:sporent/screens/cart_screen.dart';
import 'package:sporent/screens/home_screen.dart';
import 'package:sporent/screens/signin_screen.dart';
import 'package:sporent/screens/transaction_screen.dart';
import 'package:sporent/viewmodel/user_viewmodel.dart';

import '../viewmodel/order_viewmodel.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key, this.indexPage});

  final String? indexPage;

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  String? tempIndex;
  int _selectedIdx = 0;
  int counter = 0;
  bool checkPageBool = false;
  final List pageList = [
    const HomeScreen(),
    const TransactionScreen(),
    const CartScreen(),
    const ProfilePage()
  ];

  void checkUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ));
    }
  }

  void checkPage() {
    _selectedIdx = int.parse(widget.indexPage!);
    counter += 1;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checkUser();
  }

  @override
  Widget build(BuildContext context) {
    counter == 0 ? checkPage() : _selectedIdx;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) {
              var vm = UserViewModel();
              vm.signIn();
              return vm;
            },
          ),
          ChangeNotifierProvider(
            create: (context) => OrderViewModel(),
          )
        ],
        child: Scaffold(
          body: pageList[_selectedIdx],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                  label: 'Home',
                  icon: ImageIcon(AssetImage("assets/icons/Home Before.png")),
                  activeIcon:
                      ImageIcon(AssetImage("assets/icons/Home After.png"))),
              BottomNavigationBarItem(
                  label: 'Transaction',
                  icon: ImageIcon(
                      AssetImage("assets/icons/Transaction Before.png")),
                  activeIcon: FaIcon(FontAwesomeIcons.receipt)),
              BottomNavigationBarItem(
                  label: 'Cart',
                  icon: ImageIcon(AssetImage("assets/icons/Cart Before.png")),
                  activeIcon:
                      ImageIcon(AssetImage("assets/icons/Cart After.png"))),
              BottomNavigationBarItem(
                  label: 'Profile',
                  icon:
                      ImageIcon(AssetImage("assets/icons/Profile Before.png")),
                  activeIcon:
                      ImageIcon(AssetImage("assets/icons/Profile After.png")))
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
        ));
  }
}
