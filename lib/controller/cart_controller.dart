import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporent/controller/auth_controller.dart';
import 'package:sporent/model/cart.dart';
import 'package:sporent/model/cart_detail.dart';
import 'package:sporent/model/product.dart';
import 'package:sporent/model/user.dart';

class CartController {
  final firestore = FirebaseFirestore.instance;

  Future<void> addToCart(Product product, DateTime startDate, DateTime endDate,
      int quantity) async {
    UserLocal? user = await AuthController().getCurrentUser();
    log("=== user ${user?.name}", level: 3);
    var ownerRef = product.ownerRef;
    Cart? cart;
    cart = await getCart(ownerRef!);
    DocumentReference? cartDoc = cart?.toReference();
    final batch = firestore.batch();

    if (cart == null) {
      cartDoc = firestore.collection('cart').doc();
      cart = Cart(ownerRef: ownerRef, userRef: user?.toReference());
      batch.set(cartDoc, cart.toFirestore());
    }

    CartDetail cartDetail = CartDetail(
        cartRef: cartDoc,
        productRef: product.toReference(),
        quantity: quantity,
        startDate: startDate,
        endDate: endDate);
    var cartDetailRef = firestore.collection(CartDetail.path).doc();
    batch.set(cartDetailRef, cartDetail.toFirestore(), SetOptions(merge: true));

    batch.commit().onError(
        (error, stackTrace) => log("=== error add cart $error, $stackTrace"));
  }

  // Stream<List<Cart?>> getCartList ()async* {
  //   // Stream<List<Cart?>> stream= const Stream.empty();
  //
  //   var usr =await AuthController().getCurrentUser().then((value) => value?.toReference());
  //   inspect(usr);
  //   yield* firestore.where("user",isEqualTo: usr).snapshots().asyncMap((snapshot) {
  //     return Cart.fromSnapshot(snapshot.docs);
  //   });
  //   // return stream;
  // }
  Future<Cart?> getCart(DocumentReference ownerRef) async {
    UserLocal? user = await AuthController().getCurrentUser();
    var userRef = user!.toReference();
    Cart? cart = await firestore
        .collection(Cart.path)
        .where('user', isEqualTo: userRef)
        .where('owner', isEqualTo: ownerRef)
        .get()
        .then((value) {
      if (value.size == 0) {
        return null;
      }
      return Cart.fromDocument(value.docs[0].id, value.docs[0].data());
    });
    return cart;
  }

  Stream<List<Cart>?> getCartList() async* {
    var userRef = await AuthController()
        .getCurrentUser()
        .then((value) => value?.toReference());

    Stream<List<Cart>?> listCart = firestore
        .collection(Cart.path)
        .where("user", isEqualTo: userRef)
        .snapshots()
        .map((value) => Cart.fromSnapshot(value.docs));

    yield* listCart;
  }

  Stream<List<CartDetail?>> getCartDetailList(Cart cart) async* {
    // Stream<List<Cart?>> stream= const Stream.empty();

    Stream<List<CartDetail?>> listCart = firestore
        .collection(CartDetail.path)
        .where("cart", isEqualTo: cart.toReference())
        .snapshots()
        .map((snapshot) {
      return CartDetail.fromSnapshot(snapshot.docs);
    });

    yield* listCart;
    // return stream;
  }

  Future<void> deleteCart(CartDetail cartDetail) async {
    var cartDetailRef = firestore.doc(cartDetail.toReference().path);
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
