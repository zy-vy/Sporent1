import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/detail-product-card.dart';
import 'package:sporent/component/field_row.dart';
import 'package:sporent/screens/detail-transaction2.dart';
import 'package:sporent/screens/color.dart';

class DetailTransaction1 extends StatelessWidget {
  const DetailTransaction1({super.key});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
          child: const Text("Detail Transaction"),
        ),
        backgroundColor: hexStringToColor("4164DE"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: _size.height / 40, horizontal: _size.width / 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Booking Period",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: _size.height / 40),
            bookingPeriod(_size),
            SizedBox(height: _size.height / 70),
            Divider(color: hexStringToColor("E0E0E0"), thickness: 2),
            const DetailProductCard(18, 20, 15, 18, "Total Payment"),
            SizedBox(height: _size.height / 50),
            const Text(
              "Delivery Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: _size.height / 40),
            const FieldRow("Delivery Type", "Same - Day (1 - 2 Jam)", true, 15, FontWeight.normal, FontWeight.w500),
            const FieldRow("Recipient", "Umar (628123456789)", true, 15, FontWeight.normal, FontWeight.w500),
            const FieldRow("Address",
                "Jalan grogol pertamburan timur no 37 Kec. Taman Sari, Kota Jakarta Barat", true, 15, FontWeight.normal, FontWeight.w500),
            SizedBox(height: _size.height / 20),
            Center(
              child: SizedBox(
                height: _size.height / 12,
                width: _size.width,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => const DetailTransaction2())));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor("4164DE"),
                    ),
                    child: const Text("Confirm Order",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18))),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Row bookingPeriod(Size _size) => Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "30, August 2022,",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
            Text(
              "14:00",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        SizedBox(width: _size.width / 10),
        const FaIcon(FontAwesomeIcons.arrowRight),
        SizedBox(width: _size.width / 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "30, August 2022,",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
            Text(
              "16:00",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ],
    );

