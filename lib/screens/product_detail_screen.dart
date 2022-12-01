import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sporent/component/firebase_image.dart';
import 'package:sporent/component/item_price.dart';
import 'package:sporent/component/item_title.dart';
import 'package:sporent/model/product.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key,required Product product}) : _product = product,super(key: key);

  final Product _product;

  final productPath = "product-images/";

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    inspect(_product);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(

              width: size.width,
              height: size.height/2,
            child: FirebaseImage(filePath : "$productPath${_product.id}.jpg"),

            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width/20,vertical: size.width/35),
              child: ItemTitle(text: _product.name??""),
            ),
            Container(
              child: ItemPrice(price: _product.price ),
            ),

          ],
        ),
      ),
    );
  }
}
