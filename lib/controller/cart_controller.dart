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
            (error, stackTrace) =>
            log("=== error add cart $error, $stackTrace"));
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
        .map((value) {
      var listCart = Cart.fromSnapshot(value.docs);
      // listCart.forEach((cart) {
      //   getCartDetailList(cart).map((listCartDetail) {
      //     listCartDetail.forEach((cartDetail) { cartDetail?.productRef?.get().then((value) {
      //       var product = Product.fromDocument(value.id, value.data() as Map<String,dynamic>);
      //       cartDetail.product = product;
      //     },); });
      //     cart.listCartDetail = listCartDetail.cast<CartDetail>();
      //     log("=== listcartdetail : ${listCartDetail.first?.id}");
      //   },);
      //
      // });
      return listCart;
    });

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

  Stream<int> getCartItemPrice() async* {
    int total = 10;

    // await for (final listCart in getCartList()){
    //   listCart?.forEach((cart) async {
    //     await for (final listCartDetail in getCartDetailList(cart)){
    //       listCartDetail.forEach((cartDetail) async{
    //         await for (final doc in cartDetail!.productRef!.snapshots()){
    //           var product = Product.fromDocument(doc.id, doc.data() as Map<String, dynamic>);
    //           int price = (product.rentPrice!* cartDetail.quantity!)+ product.deposit!;
    //           total+=price;
    //         }
    //       });
    //     }
    //   }) ;
    // }

    // yield* getCartList().map((listCart) {
    //   if (listCart == null) return 0;
    //
    //   listCart.forEach((cart) {
    //     getCartDetailList(cart).map((listCartDetail) {
    //       for (var cartDetail in listCartDetail) {
    //         cartDetail?.productRef?.snapshots().map((doc) {
    //           var product = Product.fromDocument(
    //               doc.id, doc.data() as Map<String, dynamic>);
    //           var price = (product.rentPrice! * cartDetail.quantity!) +
    //               product.deposit!;
    //           total += price;
    //         });
    //       }
    //     });
    //   });
    //   return 0;
    // });

    log("=== total: $total");
    yield total;
  }


  Stream<int> getCartTotal() {
    // List<Cart>? listCart;

    // getCartList().listen((event) { listCart = event;});

    return getCartList().map((listCart) {
      var total = 0;

      for (var cart in listCart!) {
        getCartDetailList(cart).map(
              (listCartDetail) {
            listCartDetail.forEach((cartDetail) {
              cartDetail?.productRef?.get().then((value) {
                var product = Product.fromDocument(
                    value.id, value.data() as Map<String, dynamic>);
                var price =
                    (product.rentPrice! * cartDetail.quantity!) + product.deposit!;
                total += price;
              });
            });
          },
        );
      }


      // );
      return total;
    });
  }
}