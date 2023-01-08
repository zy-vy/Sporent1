import 'package:firebase_core/firebase_core.dart';
import 'package:sporent/screens/bottom_bar.dart';
import 'package:sporent/screens/category_screen.dart';
import 'package:sporent/screens/transaction_screen.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:sporent/screens/home_screen.dart';

import 'screens/cart.dart';
import 'screens/profile.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //   int indexPage=0;
  //   final List pageList = [
  //   const HomeScreen(),
  //   const TransactionScreen(),
  //   const CartScreen(),
  //   const ProfileScreen()
  // ];
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return

      MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SPorent',
      theme: ThemeData(

        primarySwatch: Colors.blue
      ),
      home: const BottomBarScreen()
    );

  }
}
