import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'firebase_options.dart';
import 'package:skripsi_sporent/edit-personal-info.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  //   );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int indexPage = 3;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [topProfile()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                label: 'Home',
                icon: ImageIcon(AssetImage("images/Home Before.png")),
                activeIcon: ImageIcon(AssetImage("images/Home After.png"))),
            BottomNavigationBarItem(
                label: 'Transaction',
                icon: ImageIcon(AssetImage("images/Transaction Before.png")),
                activeIcon:
                    ImageIcon(AssetImage("images/Transaction After.png"))),
            BottomNavigationBarItem(
                label: 'Cart',
                icon: ImageIcon(AssetImage("images/Cart Before.png")),
                activeIcon: ImageIcon(AssetImage("images/Cart After.png"))),
            BottomNavigationBarItem(
                label: 'Profile',
                icon: ImageIcon(AssetImage("images/Profile Before.png")),
                activeIcon: ImageIcon(AssetImage("images/Profile After.png")))
          ],
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          currentIndex: indexPage,
          onTap: (int index) {
            setState(() {
              indexPage = index;
            });
          },
        ),
      ),
    );
  }
}

Widget topProfile() {
  return Stack(
    alignment: Alignment.center,
    children: [
      Positioned(top: 60, child: profileImage()),
      Positioned(top: 200, left: 230, child: cameraButton()),
      const Positioned(
          top: 300,
          child: Text("Nasrul Ramadhan",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
      Positioned(
          top: 395,
          left: 60,
          child: Image.asset("images/EditPersonal.png", height: 40)),
      const Positioned(top: 380, child: DetailProfile()),
      const Positioned(
          top: 390,
          left: 320,
          child: Icon(Icons.keyboard_arrow_right_outlined,
              color: Colors.black, size: 40)),
      Positioned(
          top: 495,
          left: 52,
          child: Image.asset("images/Deposit.png", height: 35)),
      const Positioned(top: 480, child: DetailDeposit()),
      const Positioned(
          top: 490,
          left: 320,
          child: Icon(Icons.keyboard_arrow_right_outlined,
              color: Colors.black, size: 40)),
      Positioned(
          top: 595,
          left: 60,
          child: Image.asset("images/ChangePassword.png", height: 38)),
      const Positioned(top: 580, child: DetailPassword()),
      const Positioned(
          top: 590,
          left: 320,
          child: Icon(Icons.keyboard_arrow_right_outlined,
              color: Colors.black, size: 40)),
      Positioned(
          top: 695,
          left: 60,
          child: Image.asset("images/HelpCenter.png", height: 38)),
      const Positioned(top: 680, child: DetailHelp()),
      const Positioned(
          top: 690,
          left: 320,
          child: Icon(Icons.keyboard_arrow_right_outlined,
              color: Colors.black, size: 40)),
    ],
  );
}

Widget profileImage() => CircleAvatar(
      backgroundColor: Colors.grey.shade200,
      backgroundImage: const AssetImage("images/5864188.jpg"),
      radius: 100,
    );

Widget cameraButton() => Container(
      height: 70,
      width: 70,
      decoration:
          const BoxDecoration(color: Colors.blueAccent, shape: BoxShape.circle),
      child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(foregroundColor: Colors.white),
          child: const ImageIcon(AssetImage("images/Camera.png"))),
    );

class DetailProfile extends StatelessWidget {
  const DetailProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.4, color: Colors.grey))),
      child: TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const EditPersonalInfo(),
              ),
            );
          },
          child: Row(
            children: [
              const SizedBox(width: 57),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Edit Personal Info",
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                  Text("Name, Phone, Email Address",
                      style: TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
              const SizedBox(width: 40)
            ],
          )),
    );
  }
}

class DetailDeposit extends StatelessWidget {
  const DetailDeposit({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.4, color: Colors.grey))),
      child: TextButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 50),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Deposit Information",
                        style: TextStyle(color: Colors.black, fontSize: 20)),
                    Text("All information about deposit",
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(width: 40)
            ],
          )),
    );
  }
}

class DetailPassword extends StatelessWidget {
  const DetailPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.4, color: Colors.grey))),
      child: TextButton(
          onPressed: () {},
          child: Row(
            children: [
              const SizedBox(width: 60),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Change Password",
                        style: TextStyle(color: Colors.black, fontSize: 20)),
                    Text("Change your old password",
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(width: 40)
            ],
          )),
    );
  }
}

class DetailHelp extends StatelessWidget {
  const DetailHelp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.4, color: Colors.grey))),
      child: TextButton(
          onPressed: () {},
          child: Row(
            children: [
              const SizedBox(width: 60),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Help Center",
                        style: TextStyle(color: Colors.black, fontSize: 20)),
                    Text("Solution for your problem",
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(width: 40)
            ],
          )
        ),
    );
  }
}
