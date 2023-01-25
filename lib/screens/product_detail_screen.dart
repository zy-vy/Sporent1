import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sporent/component/firebase_image.dart';
import 'package:sporent/component/image_full_screen.dart';
import 'package:sporent/component/item_price.dart';
import 'package:sporent/component/item_title.dart';
import 'package:sporent/component/review_component.dart';
import 'package:sporent/controller/cart_controller.dart';
import 'package:sporent/model/product.dart';
import 'package:sporent/screens/owner_detail.dart';
import 'package:sporent/screens/user_review_product.dart';

import '../component/loading.dart';
import '../controller/test_user.dart';
import '../model/cart.dart';
import '../model/cart_detail.dart';
import '../model/category.dart';
import '../model/review.dart';
import '../model/user.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductDetailScreen({Key? key, required Product product})
      : _product = product,
        super(key: key);

  final Product _product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final productPath = "product-images/";

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    double total = 0;
    NumberFormat currencyFormatter =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
    File? temp;
    Size size = MediaQuery.of(context).size;
    DateTime? startDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    var dateFormat = DateFormat('dd-MM-yyyy');
    DateTime? endDate;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: HexColor("4164DE"), size: 30),
      ),
      extendBodyBehindAppBar: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
          width: size.width,
          padding: EdgeInsets.symmetric(
              horizontal: size.width / 15, vertical: size.width / 25),
          child: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => StatefulBuilder(builder:
                            (BuildContext context, StateSetter setBottomState) {
                          return Container(
                            height: size.height / 3,
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width / 15,
                                vertical: size.width / 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: const [
                                    Expanded(
                                        child: Text("Start Date: ",
                                            textAlign: TextAlign.center)),
                                    Expanded(
                                        child: Text("End Date: ",
                                            textAlign: TextAlign.center)),
                                  ],
                                ),
                                SizedBox(
                                  height: size.width / 25,
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                          child: Text(
                                              startDate != null
                                                  ? dateFormat
                                                      .format(startDate!)
                                                  : "Not selected yet",
                                              textAlign: TextAlign.center)),
                                      Expanded(
                                          child: Text(
                                              endDate != null
                                                  ? dateFormat.format(endDate!)
                                                  : "Not selected yet",
                                              textAlign: TextAlign.center)),
                                    ]),
                                SizedBox(
                                  height: size.width / 25,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                        child: IconButton(
                                      icon: const Icon(
                                          Icons.calendar_month_rounded),
                                      onPressed: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: startDate!,
                                                firstDate: DateTime.now()
                                                    .subtract(const Duration(
                                                        days: 0)),
                                                lastDate: DateTime(2100))
                                            .then((value) {
                                          if (value != null) {
                                            if (endDate != null &&
                                                value.isAfter(endDate!)) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Error ! start date must be before end date (${dateFormat.format(endDate!)})");
                                            } else {
                                              startDate = value;
                                              setBottomState(() {});
                                            }
                                          }
                                        });
                                      },
                                    )),
                                    Expanded(
                                        child: IconButton(
                                      icon: const Icon(
                                          Icons.calendar_month_rounded),
                                      onPressed: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate:
                                                    endDate ?? startDate!,
                                                firstDate: startDate!,
                                                lastDate: DateTime(2100))
                                            .then((value) {
                                          if (value != null) {
                                            endDate = value;
                                            setBottomState(() {});
                                          }
                                        });
                                      },
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  height: size.width / 20,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        log("$startDate\n$endDate");
                                        if (startDate == null ||
                                            endDate == null) {
                                          Fluttertoast.showToast(
                                              msg: "Please select date");
                                        } else {
                                          final difference = daysBetween(
                                                  startDate!, endDate!) +
                                              1;
                                          log("--- diff $difference");
                                          await CartController()
                                              .addToCart(
                                                  widget._product,
                                                  startDate!,
                                                  endDate!,
                                                  difference)
                                              .then((value) => CoolAlert.show(
                                                  context: context,
                                                  type: CoolAlertType.success,
                                                  text: "Added to Cart !",
                                                  autoCloseDuration:
                                                      const Duration(
                                                          seconds: 3)))
                                              .onError((error, stackTrace) =>
                                                  CoolAlert.show(
                                                      context: context,
                                                      type: CoolAlertType.error,
                                                      text:
                                                          "Sorry, something went wrong..."));
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: HexColor("4164DE")),
                                      child: const Text("Add to Cart")),
                                )
                              ],
                            ),
                          );
                        }));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: HexColor("4164DE"),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(right: size.width / 85),
                      child: const FaIcon(FontAwesomeIcons.cartShopping,
                          size: 15)),
                  const Text("Add to Cart"),
                ],
              ))),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
                imageUrl: widget._product.img!,
                width: size.width,
                height: size.height / 2,
                placeholder: (context, url) =>
                    const CircularProgressIndicator()),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width / 20, vertical: size.width / 35),
              child: ItemTitle(
                  text: widget._product.name ?? "",
                  fontSize: 24,
                  fontweight: FontWeight.w500,
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width / 20),
              child: ItemPrice(
                price: widget._product.rent_price,
                fontSize: 25,
                trail: true,
                color: "121212",
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width / 20, vertical: size.width / 35),
              child: Row(
                children: [
                  StreamBuilder(
                      stream: firestore
                          .collection("review")
                          .where('product',
                              isEqualTo: firestore
                                  .collection("product")
                                  .doc(widget._product.id))
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          for (var element in snapshot.data!.docs) {
                            total += element.get("star");
                          }
                          total /= snapshot.data!.docs.length;
                          if (snapshot.data!.docs.isEmpty) {
                            total = 0;
                          }
                          return Container(
                            margin: EdgeInsets.only(right: size.width / 20),
                            child: Row(
                              children: [
                                Container(
                                    margin:
                                        EdgeInsets.only(right: size.width / 80),
                                    child: FaIcon(FontAwesomeIcons.solidStar,
                                        color: HexColor("ED8A19"))),
                                Text("$total (${snapshot.data!.docs.length})",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15))
                              ],
                            ),
                          );
                        }
                      }),
                  StreamBuilder(
                    stream: firestore
                        .collection("transaction")
                        .where("product",
                            isEqualTo: firestore
                                .collection("product")
                                .doc(widget._product.id))
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        return Text("Rented 0 times",
                            style: TextStyle(
                                color: HexColor("585858"),
                                fontWeight: FontWeight.w600,
                                fontSize: 13));
                      } else {
                        var total = snapshot.data!.docs.length;
                        return Text("Rented $total times",
                            style: TextStyle(
                                color: HexColor("585858"),
                                fontWeight: FontWeight.w600,
                                fontSize: 13));
                      }
                    },
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width / 20, vertical: size.width / 35),
              child: ItemTitle(
                  text: widget._product.description ?? "",
                  fontSize: 14,
                  fontweight: FontWeight.normal,
                  maxLines: 40),
            ),
            StreamBuilder(
              stream: firestore.collection('category').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  DocumentReference categoryReference =
                      firestore.doc(widget._product.category.toString());
                  var currentCategory =
                      categoryReference.id.replaceAll(')', '');
                  for (int i = 0; i < snapshot.data!.docs.length; i++) {
                    Category category = Category.fromDocument(
                        snapshot.data!.docs[i].id,
                        snapshot.data!.docs[i].data());
                    if (category.id == currentCategory) {
                      currentCategory = category.olahraga.toString();
                    }
                  }
                  return Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width / 20, vertical: size.width / 35),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: size.width / 50),
                          child: const Text("Category:",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.normal)),
                        ),
                        ItemTitle(
                          text: currentCategory,
                          fontSize: 15,
                          fontweight: FontWeight.bold,
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            Divider(color: HexColor("E6E6E6"), thickness: 3),
            StreamBuilder(
              stream: firestore
                  .collection("user")
                  .doc(widget._product.owner!.id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  String id = "", name = "", image = "";
                  try {
                    id = snapshot.data!.id;
                    image = snapshot.data!.get("owner_image");
                    name = snapshot.data!.get("owner_name");
                  } catch (e) {
                    return const SizedBox();
                  }
                  var location = snapshot.data!.get("owner_municipality");
                  return Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width / 20, vertical: size.width / 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: ClipOval(
                              child: CachedNetworkImage(
                                  height: size.height / 13,
                                  width: size.width / 6,
                                  imageUrl: image,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator())),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => FullScreen("url", url:image),
                              ),
                            );
                          },
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(location,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: HexColor("A5A2A2")))
                          ],
                        ),
                        SizedBox(
                          height: size.height / 20,
                          width: size.width / 3.5,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => OwnerDetail(id)));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: HexColor("4164DE"),
                              ),
                              child: const Text(
                                "Visit Page",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        )
                      ],
                    ),
                  );
                }
              },
            ),
            Divider(color: HexColor("E6E6E6"), thickness: 3),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width / 20, vertical: size.width / 35),
                child: const Text("Deposit",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width / 20),
              child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                      children: <TextSpan>[
                        const TextSpan(
                          text:
                              "To rent this item, you must prepare deposit of ",
                        ),
                        TextSpan(
                            text: currencyFormatter
                                .format(widget._product.deposit_price),
                            style: const TextStyle(fontWeight: FontWeight.bold))
                      ])),
            ),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width / 20, vertical: size.width / 35),
                child: const Text(
                  "The deposit is only intended to guarantee product to be safe, later the deposit will be returned after the product are returned",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.justify,
                )),
            Divider(color: HexColor("E6E6E6"), thickness: 3),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width / 20, vertical: size.width / 35),
              child: Row(
                children: [
                  const Expanded(
                      child: Text(
                    "User Review",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                UserReview(widget._product.id)));
                      },
                      child: Text("See more",
                          style: TextStyle(color: HexColor("8B8E8F")))),
                ],
              ),
            ),
            StreamBuilder(
                stream: firestore
                    .collection('review')
                    .where('product',
                        isEqualTo: firestore
                            .collection("product")
                            .doc(widget._product.id))
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text("This Product Don't Have Review"),
                    );
                  } else {
                    Review review = Review.fromDocument(
                        snapshot.data!.docs[0].id,
                        snapshot.data!.docs[0].data());

                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width / 20),
                      child: ReviewComponent(review, false),
                    );
                  }
                }),
            SizedBox(height: size.height / 9)
          ],
        ),
      ),
    );
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  Future<void> addToCart(Product product, DateTime startDate, DateTime endDate,
      int quantity) async {
    var firestore = FirebaseFirestore.instance;
    UserLocal? user = await TestUser().getUser();
    log("=== user ${user?.name}", level: 3);
    var ownerRef = product.owner;
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

    DocumentReference? cartDoc = cart?.toReference();
    final batch = firestore.batch();

    if (cart == null) {
      cartDoc = firestore.collection('cart').doc();
      cart = Cart(ownerRef: ownerRef, userRef: user.toReference());
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
}
