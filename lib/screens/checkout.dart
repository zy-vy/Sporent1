import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sporent/component/checkout-component-detail.dart';
import 'package:sporent/component/field-row.dart';
import 'package:sporent/component/item_price.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key, required this.totalAmount});

  final int totalAmount;

  @override
  State<CheckoutPage> createState() => _CheckoutPage();
}

class _CheckoutPage extends State<CheckoutPage> {
  int counter = 0;
  File? ktpImage;
  File? transferImage;
  String? _deliveryLocation;
  String? _deliveryType;
  late int totalAmount;

  // String? _paymentMethod;

  Future<File?> openGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.gallery);
    return File(imagePicked!.path);
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    totalAmount = widget.totalAmount;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Checkout",
          style: TextStyle(fontSize: 22),
        ),
        backgroundColor: HexColor("4164DE"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: _size.height / 30, horizontal: _size.width / 13),
          child: ListView(children: [
            // const Text(
            //   "Product",
            //   style: TextStyle(
            //       fontSize: 23,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.black),
            // ),
            // SizedBox(height: _size.height / 70),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     Image.asset(
            //       'assets/images/tennis-racket.png',
            //       height: _size.height / 6,
            //       width: _size.width / 3,
            //     ),
            //     SizedBox(width: _size.width / 20),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         SizedBox(height: _size.height / 60),
            //         const Text("Raket Tenis",
            //             style: TextStyle(
            //                 fontSize: 20, fontWeight: FontWeight.normal)),
            //         SizedBox(height: _size.height / 90),
            //         const Text("Rp 150.000/Day",
            //             style: TextStyle(
            //                 fontSize: 18, fontWeight: FontWeight.bold)),
            //         SizedBox(height: _size.height / 90),
            //         Text("How many day",
            //             style: TextStyle(
            //                 fontSize: 14,
            //                 fontWeight: FontWeight.normal,
            //                 color: HexColor("969696"))),
            //         SizedBox(height: _size.height / 95),
            //         const Text("2 Hour",
            //             style: TextStyle(
            //                 fontSize: 18, fontWeight: FontWeight.w600)),
            //       ],
            //     )
            //   ],
            // ),
            // const DetailCheckout(
            //     "Delivery Location",
            //     "Umar (628123456789)",
            //     "Jalan grogol pertamburan no 20 B, Jakarta Utara",
            //     FontAwesomeIcons.locationDot,
            //     true),
            // const DetailCheckout("Type of Delivery", "Same Day (1 - 2 Jam)",
            //     "Rp 20.000", FontAwesomeIcons.truck, true),
            // const DetailCheckout("Payment Method", "OVO", "",
            //     FontAwesomeIcons.moneyCheckDollar, false),
            const Text(
              "Delivery Location",
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  icon: Icon(
                    Icons.location_on_rounded,
                    size: 30,
                  ),
                  // hintText: "Input your delivery address",
                  labelText: "Input your delivery address"),
              onChanged: (String? value) {
                _deliveryLocation = value;
              },
            ),
            const Text(
              "Courier",
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: false,
                  icon: Icon(
                    Icons.fire_truck_rounded,
                    size: 30,
                  ),
                  // hintText: "Input your delivery address",
                  labelText: "Go-send instant"),
              enabled: false,
              onSaved: (String? value) {
                _deliveryType = value;
              },
            ),
            const Text(
              "Payment Information",
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text("BCA"),
            Text("a.n Kratos Simanuntak"),
            Text("12341235"),
            const Text(
              "Upload Payment Photo",
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            // SizedBox(height: _size.height / 30),
            Row(
              children: [
                transferImage != null
                    ? SizedBox(
                        width: _size.width / 6,
                        height: _size.height / 13,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              side: BorderSide(
                                  width: 2, color: HexColor("8DA6FE"))),
                          onPressed: (() async {
                            transferImage = await openGallery();
                            setState(() {});
                          }),
                          child: Image.file(transferImage!),
                        ))
                    : SizedBox(
                        width: _size.width / 6,
                        height: _size.height / 13,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: HexColor("8DA6FE")),
                          onPressed: (() async {
                            transferImage = await openGallery();
                            setState(() {});
                          }),
                          child: const Center(
                              child: FaIcon(FontAwesomeIcons.plus,
                                  color: Colors.white, size: 30)),
                        ),
                      )
              ],
            ),
            SizedBox(height: _size.height / 30),
            const Text(
              "Upload KTP Document",
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: _size.height / 70),
            Row(
              children: [
                ktpImage != null
                    ? SizedBox(
                        width: _size.width / 6,
                        height: _size.height / 13,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              side: BorderSide(
                                  width: 2, color: HexColor("8DA6FE"))),
                          onPressed: (() async {
                            ktpImage = await openGallery();
                            setState(() {});
                          }),
                          child: Image.file(ktpImage!),
                        ))
                    : SizedBox(
                        width: _size.width / 6,
                        height: _size.height / 13,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: HexColor("8DA6FE")),
                          onPressed: (() async {
                            ktpImage = await openGallery();
                            setState(() {});
                          }),
                          child: const Center(
                              child: FaIcon(FontAwesomeIcons.plus,
                                  color: Colors.white, size: 25)),
                        ),
                      )
              ],
            ),
            SizedBox(height: _size.height / 30),
            const Text(
              "Order Info",
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: _size.height / 70),
            // const FieldRow("Shipping Fee", "Rp 20.000", false, 17,
            //     FontWeight.normal, FontWeight.w500),
            // const FieldRow("Price Total", "Rp 300.000", false, 17,
            //     FontWeight.normal, FontWeight.w500),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Total",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),), ItemPrice(price: totalAmount,textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),trail: false)],),
              // const FieldRow("Deposit", "Rp 1.500.000", false, 17,
              //     FontWeight.normal, FontWeight.w500),
            // const FieldRow("Total", "Rp 1.820.000", false, 20, FontWeight.bold,
            //     FontWeight.bold),
            SizedBox(height: _size.height / 70),
            Center(
              child: SizedBox(
                height: _size.height / 13,
                width: _size.width,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor("4164DE"),
                    ),
                    child: const Text("Confirm",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18))),
              ),
            ),
            SizedBox(height: _size.height / 70),
          ])),
    );
  }
}
