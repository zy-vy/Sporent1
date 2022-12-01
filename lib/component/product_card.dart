
import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sporent/component/firebase_image.dart';
import 'package:sporent/model/product.dart';
import 'package:sporent/screens/product_detail_screen.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({Key? key, required Product product})
      : _product = product,
        super(key: key);

  final Product _product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final productPath = "product-images/";

  @override
  Widget build(BuildContext context) {
    final Reference storage = FirebaseStorage.instance.ref();
    final pathRef = storage.child(productPath + widget._product.id!);
    log("+++ product${widget._product.name}");

    // Size _size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(product: widget._product),));
      },
      child: Card(
        child: Column(
          children: [
            AspectRatio(

              aspectRatio: 1,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: FirebaseImage(filePath : "$productPath${widget._product.id}.jpg")),
                  // child: Icon(Icons.access_time)),
            ),
            Expanded(
              // padding: const EdgeInsets.all(7),
              // decoration: BoxDecoration(border: Border.all()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget._product.name??"",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Rp. ${widget._product.price??""}/hour",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Row(children: [
                    const Icon(Icons.location_on),
                    Text(widget._product.location??"")
                  ],)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
