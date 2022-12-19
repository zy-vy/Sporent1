import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sporent/component/firebase_image.dart';
import 'package:sporent/component/item_price.dart';
import 'package:sporent/model/cart_detail.dart';
import 'package:sporent/model/product.dart';
import 'package:sporent/screens/product_detail_screen.dart';
import 'package:sporent/util/provider/item_count.dart';
import 'package:sporent/util/provider/total_price.dart';


class CartDetailTile extends StatelessWidget {
  final CartDetail cartDetail;

  const CartDetailTile({Key? key, required this.cartDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imagePath = "${Product.imagePath}/";
    var productRef =
        FirebaseFirestore.instance.doc(cartDetail.productRef!.path);
    var dateFormat = DateFormat('dd-MM-yyyy');
    Product product;

    return FutureBuilder(
        future: getProduct(productRef.path),
        builder: (context, snapshot) {
          if (!snapshot.hasData){
            return const Center(child: CircularProgressIndicator(strokeWidth: 1),);
          }
          product = snapshot.data!;
          var price = (product.rentPrice!*cartDetail.quantity!)+product.deposit!;

          Future.delayed(const Duration(seconds: 1), () async {
          });
          Provider.of<TotalPriceProvider>(context,listen: true).addToCart(price);

          // Provider.of<ItemCountProvider>(context,listen: true).addToCart();
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
                      const Text("Deposit :"),
                      ItemPrice(price: product.deposit,trail: false,),
                    ],
                  ),
                  const Divider(thickness: 0.3, color: Colors.lightBlueAccent),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(" "),
                      Align(alignment : Alignment.centerRight,child: ItemPrice(price: price,trail: false,)),
                    ],
                  ),
                ],
              ),
              trailing: IconButton(onPressed: () {
                  deleteCart(cartDetail);
              }, icon: const Icon(Icons.delete_outline_rounded))
            ),
          );
        });
  }
  Future<Product?> getProduct (String productRef) async {
    var firestore = FirebaseFirestore.instance;

    return firestore.doc(productRef).get().then((value) => Product.fromDocument(value.id, value.data()!));
  }

  Future<void> deleteCart(CartDetail cartDetail) async {
    var firestore = FirebaseFirestore.instance;
    var cartDetailRef = firestore.doc(cartDetail
        .toReference()
        .path);
    var cartRef = cartDetail.cartRef;
    var cartDetailList = await firestore
        .collection(CartDetail.path)
        .where("cart", isEqualTo: cartRef)
        .get();
    var batch = firestore.batch();
    if (cartDetailList.docs.length == 1) {
      batch.delete(cartRef!);
    }
    batch.delete(cartDetailRef);
    batch.commit();
  }
}
