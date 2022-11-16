import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:skripsi_sporent/screens/change-password.dart';
import 'package:skripsi_sporent/screens/deposit-information.dart';
import 'package:skripsi_sporent/screens/input-renter-name.dart';
import '/firebase_options.dart';
import 'package:skripsi_sporent/screens/edit-personal-info.dart';
import 'package:skripsi_sporent/screens/help-center.dart';
import 'package:image_picker/image_picker.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
        body: IndexedStack(
          index: indexPage,
          children: const [
            HomePage(),
            TransactionPage(),
            CartPage(),
            ProfilePage(),
          ],
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

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? image;

  Future openGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(imagePicked!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
            top: 60,
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              backgroundImage: image != null
                  ? FileImage(image!) as ImageProvider
                  : const AssetImage("images/5864188.jpg"),
              radius: 100,
            )),
        Positioned(
            top: 200,
            left: 230,
            child: Container(
              height: 70,
              width: 70,
              decoration: const BoxDecoration(
                  color: Colors.blueAccent, shape: BoxShape.circle),
              child: TextButton(
                  onPressed: () async {
                    await openGallery();
                  },
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                  child: const ImageIcon(AssetImage("images/Camera.png"))),
            )),
        const Positioned(
            top: 280,
            child: Text("Nasrul Ramadhan",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
        Positioned(
            top: 330,
            child: SizedBox(
              width: 230,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const InputRenterName(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor("4164DE")),
                child: const Text(
                  "Become Renter",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )),
        Positioned(
            top: 420,
            left: 60,
            child: Image.asset("images/EditPersonal.png", height: 40)),
        const Positioned(top: 405, child: DetailProfile()),
        const Positioned(
            top: 415,
            left: 320,
            child: Icon(Icons.keyboard_arrow_right_outlined,
                color: Colors.black, size: 40)),
        Positioned(
            top: 500,
            left: 52,
            child: Image.asset("images/Deposit.png", height: 35)),
        const Positioned(top: 485, child: DetailDeposit()),
        const Positioned(
            top: 495,
            left: 320,
            child: Icon(Icons.keyboard_arrow_right_outlined,
                color: Colors.black, size: 40)),
        Positioned(
            top: 585,
            left: 60,
            child: Image.asset("images/ChangePassword.png", height: 38)),
        const Positioned(top: 570, child: DetailPassword()),
        const Positioned(
            top: 580,
            left: 320,
            child: Icon(Icons.keyboard_arrow_right_outlined,
                color: Colors.black, size: 40)),
        Positioned(
            top: 675,
            left: 60,
            child: Image.asset("images/HelpCenter.png", height: 38)),
        const Positioned(top: 660, child: DetailHelp()),
        const Positioned(
            top: 670,
            left: 320,
            child: Icon(Icons.keyboard_arrow_right_outlined,
                color: Colors.black, size: 40)),
        Positioned(
            top: 740,
            child: TextButton(
                onPressed: () {},
                child: Text("Log Out",
                    style: TextStyle(
                        color: HexColor("DE4141"),
                        fontWeight: FontWeight.bold,
                        fontSize: 18))))
      ],
    );
  }
}

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
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const DepositInformation(),
              ),
            );
          },
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
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const EditPassword(),
              ),
            );
          },
          child: Row(
            children: [
              const SizedBox(width: 59),
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
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HelpCenter(),
              ),
            );
          },
          child: Row(
            children: [
              const SizedBox(width: 55),
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
          )),
    );
  }
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPage();
}

class _CartPage extends State<CartPage> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
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
        padding: const EdgeInsets.only(top: 20, left: 30, right: 35, bottom: 35),
        child: Column(
          children: [
            Expanded(
              child:  ListView(
              children: [
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'images/tennis-racket.png',
                          height: 130,
                          width: 130,
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Raket Tenis",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.normal)),
                            const SizedBox(height: 6),
                            const Text("Rp 150.000/Day",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 6),
                            Text("How many day",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: HexColor("969696"))),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: HexColor("416DDE"),
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (counter > 0) {
                                            counter--;
                                          }
                                        });
                                      },
                                      icon: const FaIcon(
                                        FontAwesomeIcons.minus,
                                        color: Colors.white,
                                        size: 20,
                                      )),
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  "$counter",
                                  style: const TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 15),
                                CircleAvatar(
                                  backgroundColor: HexColor("416DDE"),
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          counter++;
                                        });
                                      },
                                      icon: const FaIcon(
                                        FontAwesomeIcons.plus,
                                        color: Colors.white,
                                        size: 20,
                                      )),
                                ),
                                const SizedBox(width: 10),
                                IconButton(
                                    onPressed: () {},
                                    icon: FaIcon(
                                      FontAwesomeIcons.trash,
                                      color: HexColor("808080"),
                                    ))
                              ],
                            )
                          ],
                        )
                      ],
                    ),
              ],
            ),),
            Divider(thickness: 1, color: HexColor("A3A3A3")),
            const SizedBox(height: 15),
            Row(
              children: const [
                Expanded(
                  child: Text("Total: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
                Text("Rp 300.000", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
              ],
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor("4164DE")
                ),
                onPressed: (){}, 
                child: const Text("Checkout", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
            )
          ],
        ),
      ),
    );
  }
}

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Add Product"),
          ),
          backgroundColor: HexColor("4164DE"),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, left: 20, right: 35, bottom: 35),
              child: Column(),
            ),
          ],
        ));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
          child: const Text("Add Product"),
        ),
        backgroundColor: HexColor("4164DE"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 30, left: 20, right: 35, bottom: 35),
        child: Column(),
      ),
    );
  }
}
