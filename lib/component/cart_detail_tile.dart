import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';
import 'package:sporent/component/firebase_image.dart';
import 'package:sporent/component/item_price.dart';
import 'package:sporent/controller/product_controller.dart';
import 'package:sporent/model/cart_detail.dart';
import 'package:sporent/model/product.dart';
import 'package:sporent/screens/product_detail_screen.dart';

import '../controller/cart_controller.dart';

class CartDetailTile extends StatelessWidget {
  final CartDetail cartDetail;

  const CartDetailTile({Key? key, required this.cartDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imagePath = "${Product.imagePath}/";
    var productRef =
        FirebaseFirestore.instance.doc(cartDetail.productRef!.path);
    var dateFormat = DateFormat('dd-MM-yyyy');

    return FutureBuilder(
        future: ProductController().getProduct(productRef.path),
        builder: (context, snapshot) {
          if (!snapshot.hasData){
            return const Center(child: CircularProgressIndicator(strokeWidth: 1),);
          }
          var product = snapshot.data!;
          var total=0;
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product),));
              },
              leading: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: FirebaseImage(
                        filePath: "$imagePath${productRef.id}.jpg")),
                // child: Icon(Icons.access_time)),
              ),
              title: Text("${product.name}",maxLines: 1,overflow: TextOverflow.ellipsis,),
              subtitle: Column(
                children: [
                  Row(
                    children: [
                      Text("start   : ${dateFormat.format(cartDetail.startDate!)}",overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,),
                    ],
                  ),
                  Row(
                    children: [
                      Text("end     : ${dateFormat.format(cartDetail.endDate!)}",overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,)
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ItemPrice(price: product.rentPrice,trail: true,),
                      Text(" x ${cartDetail.quantity}  "),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(" "),
                      Align(alignment : Alignment.centerRight,child: ItemPrice(price: product.rentPrice!*cartDetail.quantity!,trail: false,)),
                    ],
                  ),
                ],
              ),
              trailing: IconButton(onPressed: () {
                  CartController().deleteCart(cartDetail);
              }, icon: const Icon(Icons.delete_outline_rounded))
            ),
          );
        });
  }
}
