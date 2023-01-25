import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
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

    Size _size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: _product),
            ));
      },
      child: Card(
          color: const Color.fromRGBO(238, 238, 238, 1),
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 2)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1 ,
                child: ClipRRect(
                      borderRadius: BorderRadius.circular(5) ,
                      child:
                        CachedNetworkImage(imageUrl: '${_product.img}', fit: BoxFit.fitHeight,),
                ) ,

              ),
              Padding(
                padding: EdgeInsets.only(left: _size.width/30, top: _size.height/50),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _product.name ?? "",
                        style: const TextStyle(fontSize: 16, overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(height: _size.height/90),
                      ItemPrice(
                            price: _product.rent_price!,
                            trail: true,
                            fontSize: 14,
                            color: "494949",
                      ),
                      SizedBox(height: _size.height/90),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.locationDot, color: HexColor("494949"), size: 14,),
                          SizedBox(width: _size.width/70),
                          Text(_product.location ?? "",style: const TextStyle(fontSize: 14),)
                        ],
                      ),
                    ],
                  ),
              ),
              
            ],
          ),
        ),
    );
  }
}
