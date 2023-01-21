import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sporent/component/firebase_image.dart';
import 'package:sporent/utils/colors.dart';

class DetailTransactionCard extends StatelessWidget {
  const DetailTransactionCard(this.fontTitle, this.fontProduct,
      this.fontDuration, this.fontTotal, this.text, this.image, this.name, this.total,
      {super.key});

  final double? fontTitle;
  final double? fontProduct;
  final double? fontDuration;
  final double? fontTotal;
  final String text;
  final String image;
  final String name;
  final int total;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
     NumberFormat currencyFormatter =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: _size.height / 70),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Detail Product",
                    style: TextStyle(
                        fontSize: fontTitle,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: _size.height / 50),
                  Row(
                    children: [
                      SizedBox(
                          width: _size.width / 3,
                          height: _size.height / 5.8,
                          child:
                              FirebaseImage(filePath: "product-images/$image")),
                      SizedBox(width: _size.width / 15),
                      Expanded(child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: fontProduct,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(height: _size.height / 80),
                          Text(
                            text,
                            style: TextStyle(
                                fontSize: fontTotal,
                                color: hexStringToColor("999999")),
                          ),
                          SizedBox(height: _size.height / 95),
                          Text(
                           currencyFormatter.format(total),
                            style: TextStyle(
                                fontSize: fontTotal,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        ],
                      ))
                    ],
                  ),
                ])),
      ],
    );
  }
}
