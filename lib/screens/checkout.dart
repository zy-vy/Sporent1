import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sporent/component/firebase_image.dart';
import 'package:sporent/component/image_full_screen.dart';
import 'package:sporent/component/item_price.dart';
import 'package:sporent/component/transaction_card_detail.dart';
import 'package:sporent/model/order.dart';
import 'package:sporent/model/product.dart';

import '../model/cart.dart';
import '../viewmodel/transaction_viewmodel.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage(
      {super.key, required this.totalAmount, required this.cartList});

  final int totalAmount;

  final List<Cart> cartList;

  @override
  State<CheckoutPage> createState() => _CheckoutPage();
}

class _CheckoutPage extends State<CheckoutPage> {
  File? ktpImage;
  File? transferImage;
  String? _deliveryLocation;
  String? _deliveryType = "Go-send instant";
  late int totalAmount;
  var index = 0;
  int counter = 0;
  // late int price =0 , totalDeposit=0;
  var isRebuild = false;
  final TextEditingController controller = TextEditingController();
  var totalDeposit = TotalDeposit();
  NumberFormat currencyFormatter =
      NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
  // String? _paymentMethod;
  final _formKey = GlobalKey<FormState>();
  Future<File?> openGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.gallery);
    return File(imagePicked!.path);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    totalAmount = widget.totalAmount;
    var cartList = widget.cartList;
    var currentPage = [
      checkout(context, size, cartList),
      payment(context, size, cartList)
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Checkout",
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: HexColor("4164DE"),
      ),
      // backgroundColor: Colors.white,
      body: currentPage[index],
    );
  }

  Widget checkout(BuildContext context, Size size, List<Cart> cartList) {
    var dateFormat = DateFormat('d MMMM ' 'yyyy');

    return Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height / 30, horizontal: size.width / 13),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Detail Product",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartList.length,
                        itemBuilder: (context, index) {
                          var cart = cartList[index];
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cart.listCartDetail!.length,
                              itemBuilder: (context, index1) {
                                var cartDetail = cart.listCartDetail![index1];
                                return FutureBuilder(
                                    future: FirebaseFirestore.instance
                                        .doc(cartDetail.productRef!.path)
                                        .get(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Center();
                                      }
                                      var product = snapshot.data!;
                                      if (!isRebuild) {
                                        totalDeposit.price +=
                                            (product.get("rent_price") as int) *
                                                cartDetail.quantity!;
                                        totalDeposit.deposit +=
                                            product.get("deposit_price") as int;
                                        // Provider.of<TotalDeposit>(context,listen: false).price += (product.get("rent_price") as int )* cartDetail.quantity!;
                                        // Provider.of<TotalDeposit>(context,listen: false).deposit += product.get("deposit_price") as int;
                                      }
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: size.width / 35),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  height: size.height / 50),
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: ShapeDecoration(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            side: BorderSide(
                                                                width: 2,
                                                                color: HexColor(
                                                                    "8DA6FE")))),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: product
                                                              .get("img"),
                                                          fit: BoxFit.fill,
                                                          width: size.width / 4,
                                                          height:
                                                              size.height / 10,
                                                          placeholder: (context,
                                                                  url) =>
                                                              const CircularProgressIndicator(),
                                                        )),
                                                  ),
                                                  SizedBox(
                                                      width: size.width / 15),
                                                  Expanded(
                                                      child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        product.get("name"),
                                                        maxLines: 2,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      SizedBox(
                                                          height:
                                                              size.height / 80),
                                                      Text(
                                                        "${currencyFormatter.format(product.get("rent_price"))}/Day",
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      SizedBox(
                                                          height:
                                                              size.height / 80),
                                                      Text(
                                                        "Duration: ${cartDetail.quantity} Day",
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ))
                                                ],
                                              ),
                                            ]),
                                      );
                                    });
                              });
                        }),
                    SizedBox(
                      height: size.width / 20,
                    ),
                    const Text(
                      "Delivery Location",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: size.width / 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              width: size.width / 6,
                              height: size.width / 6,
                              color: HexColor("8DA6FE"),
                              child: const Center(
                                  child: FaIcon(FontAwesomeIcons.locationDot,
                                      color: Colors.white, size: 25)),
                            )),
                        SizedBox(width: size.width / 20),
                        Flexible(
                          child: TextFormField(
                            controller: controller,
                            decoration: const InputDecoration(
                                labelText: "Input your delivery address"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Address must not be empty";
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.width / 20,
                    ),
                    const Text(
                      "Type of Delivery",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: size.width / 30,
                    ),
                    Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              width: size.width / 6,
                              height: size.width / 6,
                              color: HexColor("8DA6FE"),
                              child: const Center(
                                  child: FaIcon(FontAwesomeIcons.truck,
                                      color: Colors.white, size: 25)),
                            )),
                        SizedBox(width: size.width / 20),
                        const Text("Go-Send Instant",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15))
                      ],
                    ),
                    SizedBox(
                      height: size.width / 20,
                    ),
                    const Text(
                      "Upload KTP Document",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: size.width / 30),
                    Row(
                      children: [
                        ktpImage != null
                            ? Stack(children: [
                                SizedBox(
                                    width: size.width / 6,
                                    height: size.width / 6,
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                            side: BorderSide(
                                                width: 2,
                                                color: HexColor("8DA6FE"))),
                                        onPressed: (() async {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => FullScreen(
                                                "file",
                                                image: ktpImage),
                                          ));
                                        }),
                                        child: Image.file(
                                          ktpImage!,
                                          fit: BoxFit.fill,
                                        ))),
                                Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                        height: 25,
                                        width: 25,
                                        decoration: const BoxDecoration(
                                            color: Colors.blueAccent,
                                            shape: BoxShape.circle),
                                        child: IconButton(
                                          icon: const FaIcon(
                                              FontAwesomeIcons.xmark,
                                              size: 10,
                                              color: Colors.white),
                                          onPressed: () {
                                            setState(() {
                                              ktpImage = null;
                                            });
                                          },
                                        ))),
                              ])
                            : SizedBox(
                                width: size.width / 6,
                                height: size.width / 6,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: HexColor("8DA6FE")),
                                  onPressed: (() async {
                                    ktpImage = await openGallery();
                                    isRebuild = true;
                                    setState(() {});
                                  }),
                                  child: const Center(
                                      child: FaIcon(FontAwesomeIcons.plus,
                                          color: Colors.white, size: 25)),
                                ),
                              )
                      ],
                    ),
                    SizedBox(height: size.width / 20),
                    const Text(
                      "Order Info",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: size.width / 30),
                    FutureBuilder(
                      future: wait(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return const Center(
                            child: LinearProgressIndicator(),
                          );
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Price total",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                                // Consumer<TotalDeposit>( builder: (context, totalDrposit, child) =>  ItemPrice(textStyle:  const TextStyle(color: Colors.black54,fontSize: 14,fontWeight: FontWeight.bold), price: price,)),
                                ItemPrice(
                                  textStyle: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  price: totalDeposit.price,
                                )
                              ],
                            ),
                            SizedBox(height: size.width / 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Deposit",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                                // Consumer<TotalDeposit>( builder: (context, totalDrposit, child) =>  ItemPrice(textStyle:  const TextStyle(color: Colors.black54,fontSize: 14,fontWeight: FontWeight.bold), price: totalDeposit,)),
                                ItemPrice(
                                  textStyle: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  price: totalDeposit.deposit,
                                )
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: size.width / 30),
                    Row(
                      children: const [
                        Icon(
                          Icons.warning_rounded,
                          color: Colors.redAccent,
                          size: 14,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                            style: TextStyle(
                                fontSize: 14, color: Colors.redAccent),
                            "Shipping fee has not included!"),
                      ],
                    ),
                    SizedBox(height: size.width / 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        ItemPrice(
                            price: totalAmount,
                            textStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            trail: false)
                      ],
                    ),
                    SizedBox(height: size.height / 70),
                    Center(
                      child: SizedBox(
                        height: size.height / 13,
                        width: size.width,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (ktpImage == null) {
                                  CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.error,
                                      text:
                                          "Please input correct information...");
                                  return;
                                }
                                setState(() {
                                  isRebuild = true;
                                  index = 1;
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: HexColor("4164DE"),
                            ),
                            child: const Text("Confirm",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))),
                      ),
                    ),
                    SizedBox(height: size.height / 70),
                  ])),
        ));
  }

  Widget payment(BuildContext context, Size size, List<Cart> cartList) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width / 15,
        vertical: size.width / 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Payment Information",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: size.height / 50),
          const Text(
            "Harap melakukan pembayaran ke no rekening berikut ini untuk dapat memproses pesananmu",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
          ),
          SizedBox(height: size.height / 30),
          Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    width: size.width / 6,
                    height: size.width / 6,
                    color: HexColor("8DA6FE"),
                    child: const Center(
                        child: FaIcon(FontAwesomeIcons.buildingColumns,
                            color: Colors.white, size: 25)),
                  )),
              SizedBox(
                width: size.width / 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "BCA",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  Text("5278763119",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15))
                ],
              )
            ],
          ),
          SizedBox(height: size.height / 30),
          const Text(
            "Payment Information",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: size.height / 50),
          const Text(
            "Mohon upload bukti pembayaran kamu agar pesananmu bisa diproses",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
          ),
          SizedBox(height: size.height / 30),
          Row(
            children: [
              transferImage != null
                  ? Stack(children: [
                                SizedBox(
                                    width: size.width / 6,
                                    height: size.width / 6,
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                            side: BorderSide(
                                                width: 2,
                                                color: HexColor("8DA6FE"))),
                                        onPressed: (() async {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => FullScreen(
                                                "file",
                                                image: transferImage),
                                          ));
                                        }),
                                        child: Image.file(
                                          transferImage!,
                                          fit: BoxFit.fill,
                                        ))),
                                Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                        height: 25,
                                        width: 25,
                                        decoration: const BoxDecoration(
                                            color: Colors.blueAccent,
                                            shape: BoxShape.circle),
                                        child: IconButton(
                                          icon: const FaIcon(
                                              FontAwesomeIcons.xmark,
                                              size: 10,
                                              color: Colors.white),
                                          onPressed: () {
                                            setState(() {
                                              transferImage = null;
                                            });
                                          },
                                        ))),
                              ])
                  : SizedBox(
                      width: size.width / 6,
                      height: size.width / 6,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: HexColor("8DA6FE")),
                        onPressed: (() async {
                          transferImage = await openGallery();
                          isRebuild = true;
                          setState(() {});
                        }),
                        child: const Center(
                            child: FaIcon(FontAwesomeIcons.plus,
                                color: Colors.white, size: 30)),
                      ),
                    )
            ],
          ),
          SizedBox(height: size.width / 20),
          const Spacer(),
          SizedBox(
            height: size.height / 13,
            child: ElevatedButton(
                onPressed: () async {
                  if (ktpImage == null || transferImage == null) {
                    CoolAlert.show(
                        context: context,
                        type: CoolAlertType.error,
                        text: "Please input correct information...");
                    return;
                  }

                  for (var cart in cartList) {
                    var cartDetailList = cart.listCartDetail;
                    for (var cartDetail in cartDetailList!) {
                      Order order = Order(
                        total: cartDetail.total,
                        quantity: cartDetail.quantity,
                        productRef: cartDetail.productRef,
                        deliveryMethod: _deliveryType,
                        deliveryLocation: controller.text,
                        startDate: cartDetail.startDate,
                        endDate: cartDetail.endDate,
                        ownerRef: cart.ownerRef,
                        userRef: cart.userRef,
                        ktpFile: ktpImage,
                        paymentFile: transferImage,
                      );
                      await TransactionViewModel()
                          .checkout(cartDetail, order, null)
                          .then((value) {
                        if (value) {
                          CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.success,
                                  text:
                                      "Checkout Success!\nYou can check in transaction menu")
                              .then((value) => Navigator.pop(context));
                          //
                        } else {
                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.error,
                              text: "Sorry, something went wrong");
                        }
                      });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor("4164DE"),
                ),
                child: const Text("Confirm",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18))),
          ),
        ],
      ),
    );
  }

  Future<bool> wait() async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}

class TotalDeposit {
  int _price = 0;
  int _deposit = 0;
  // bool isRebuild = false;

  int get price => _price;

  set price(int value) {
    _price = value;
    // notifyListeners();
  }

  int get deposit => _deposit;

  set deposit(int value) {
    _deposit = value;
    // notifyListeners();
  }
}
