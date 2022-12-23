
import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sporent/component/firebase_image.dart';
import 'package:sporent/component/item_price.dart';
import 'package:sporent/model/product.dart';
import 'package:sporent/screens/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required Product product})
      : _product = product,
        super(key: key);

  final Product _product;


  @override
  Widget build(BuildContext context) {
    final Reference storage = FirebaseStorage.instance.ref();
    final pathRef = storage.child("${Product.imagePath!}/${_product.id!}");
    log("+++ product${_product.name}");

    // Size _size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(product: _product),));
      },
      child: Card(
        child: Column(
          children: [
            AspectRatio(

              aspectRatio: 1,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: FirebaseImage(filePath : "${Product.imagePath}/${_product.id}.jpg")),
                  // child: Icon(Icons.access_time)),
            ),
            Expanded(
              // padding: const EdgeInsets.all(7),
              // decoration: BoxDecoration(border: Border.all()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    _product.name??"",
                    style: const TextStyle(fontSize: 16),
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ItemPrice(price: _product.rentPrice!,trail: true,textStyle: const TextStyle(fontSize: 20),),
                    ],
                  ),
                  Row(children: [
                    const Icon(Icons.location_on),
                    Text(_product.location??"")
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
