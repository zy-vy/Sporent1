import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../controller/auth_controller.dart';
import '../model/cart.dart';
import '../model/cart_detail.dart';
import '../model/product.dart';

class CartRepository {
  final firestore = FirebaseFirestore.instance;

  Future<List<Cart>?> getCartList() async {
    var userRef = await AuthController()
        .getCurrentUser()
        .then((value) => value?.toReference());

    Future<List<Cart>?> future = firestore
        .collection(Cart.path)
        .where("user", isEqualTo: userRef)
        .get()
        .then((value) async {
      var listCart = Cart.fromSnapshot(value.docs);
      for (var cart in listCart) {
        var listCartDetail = await getCartDetailList(cart).then(
          (listCartDetail) async {
            var total = 0;
            for (var cartDetail in listCartDetail)  {
              var product = await cartDetail?.productRef?.get().then((value) =>
                  Product.fromDocument(
                      value.id, value.data() as Map<String, dynamic>));
              cartDetail?.product = product;
              var price = (product!.rentPrice! * cartDetail!.quantity!) +
                  product.deposit!;
              cartDetail.total = price;
              total += price;
            }
            cart.totalPrice = total;
            // log("=== listcartdetail : ${listCartDetail.first?.id}");
            return listCartDetail;
          },

        );
        cart.listCartDetail = listCartDetail.cast<CartDetail>();

      }
      return listCart;
    });
    return future;
  }

  Future<List<CartDetail?>> getCartDetailList(Cart cart) async {
    // Stream<List<Cart?>> stream= const Stream.empty();

    Future<List<CartDetail?>> listCart = firestore
        .collection(CartDetail.path)
        .where("cart", isEqualTo: cart.toReference())
        .get()
        .then((snapshot) {
      return CartDetail.fromSnapshot(snapshot.docs);
    });

    return listCart;
    // return stream;
  }

  Future<void> deleteCart(CartDetail cartDetail) async {
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
