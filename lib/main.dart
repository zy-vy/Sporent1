import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sporent/screens/bottom_bar.dart';
import 'firebase_options.dart';

import 'screens/cart.dart';
import 'screens/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SPorent',
        theme: ThemeData(primarySwatch: Colors.blue),
        home:
            // MultiProvider(providers: [
            //   ChangeNotifierProvider(create: (context) => UserViewModel(),)
            // ],
            //   child: const BottomBarScreen(),
            // )
            const BottomBarScreen(indexPage: "0",));
  }
}
