import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sporent/component/checkout-component-detail.dart';
import 'package:sporent/component/field_row.dart';
import 'package:sporent/component/firebase_image.dart';
import 'package:sporent/component/item_price.dart';
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
  int counter = 0;
  File? ktpImage;
  File? transferImage;
  String? _deliveryLocation;
  String? _deliveryType = "Go-send instant";
  late int totalAmount;
  var index =0;
  // String? _paymentMethod;

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
    var price =0 , totalDeposit=0;
    var currentPage = [ checkout(context,size,cartList,price,totalDeposit),payment(context, size, cartList)];

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

  Widget checkout (BuildContext context,Size size, List<Cart> cartList, int price,int totalDeposit){

    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.height / 30, horizontal: size.width / 13),
          child:
          ChangeNotifierProvider<TotalDeposit>(
            create: (context) => TotalDeposit(),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                          return StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .doc(cartDetail.productRef!.path)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) return const Center();
                                var product = snapshot.data!;
                                price += (product.get("rent_price") as int )* cartDetail.quantity!;
                                totalDeposit += product.get("deposit_price") as int;
                                Provider.of<TotalDeposit>(context,listen: false).price += (product.get("rent_price") as int )* cartDetail.quantity!;
                                Provider.of<TotalDeposit>(context,listen: false).deposit += product.get("deposit_price") as int;
                                return Padding(
                                  padding:  EdgeInsets.symmetric(vertical : size.width/35),
                                  child: Row(children: [
                                    SizedBox(
                                      width:size.width/5,
                                      child: AspectRatio(
                                          aspectRatio: 1,
                                          child: FirebaseImage(
                                            filePath:
                                            "${Product.imagePath}/${product.get("img")}",
                                          )),
                                    ),
                                    SizedBox(width: size.width/20,),
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.get("name") ?? "",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                          ),
                                          ItemPrice(
                                            price: product.get("rent_price"),
                                            trail: true,
                                          ),
                                          Text(
                                            "duration : ${cartDetail.quantity}",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            // style: const TextStyle(
                                            //     fontWeight: FontWeight.bold),
                                          ),
                                        ]),
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
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    icon: Icon(
                      Icons.location_on_rounded,
                      size: 30,
                    ),
                    // hintText: "Input your delivery address",
                    labelText: "Input your delivery address"),
                onChanged: (String? value) {
                  _deliveryLocation = value;
                },

              ),
              SizedBox(
                height: size.width / 20,
              ),

              const Text(
                "Courier",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: size.width / 30,
              ),

              TextFormField(
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    filled: false,
                    icon: const Icon(
                      Icons.fire_truck_rounded,
                      size: 30,
                    ),
                    // hintText: "Input your delivery address",
                    labelText: _deliveryType),
                enabled: false,
                onSaved: (String? value) {
                  _deliveryType = value;
                },
              ),
              SizedBox(
                height: size.width / 20,
              ),

              const Text(
                "Payment Information",
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
                  Icon(
                    Icons.account_balance,
                    size: 30,
                    color: HexColor("999999"),
                  ),
                  SizedBox(
                    width: size.width / 18,
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .doc("/payment/HzOEGwGyA5Slx1HZmaeu")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Expanded(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ));
                        }
                        // var name =snapshot.data!.get("account_name");
                        var number = snapshot.data!.get("account_number");
                        var bank = snapshot.data!.get("bank");
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(bank.toString()),
                            Text("$number")
                          ],
                        );
                      })
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
                      ? SizedBox(
                      width: size.width / 6,
                      height: size.width / 6,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            side: BorderSide(
                                width: 2, color: HexColor("8DA6FE"))),
                        onPressed: (() async {
                          ktpImage = await openGallery();
                          setState(() {});
                        }),
                        child: Image.file(
                          ktpImage!,
                          fit: BoxFit.fill,
                        ),
                      ))
                      : SizedBox(
                    width: size.width / 6,
                    height: size.width / 6,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: HexColor("8DA6FE")),
                      onPressed: (() async {
                        ktpImage = await openGallery();
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
              FutureBuilder(future: wait(), builder: (context, snapshot) {
                if (!snapshot.hasData)return const Center(child: LinearProgressIndicator(),);
                return Column(children: [Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                  const Text(
                    "Price total",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  Consumer<TotalDeposit>( builder: (context, totalDrposit, child) =>  ItemPrice(textStyle:  const TextStyle(color: Colors.black54,fontSize: 14,fontWeight: FontWeight.bold), price: price,)),
                ],),

                  SizedBox(height: size.width / 30),
                  Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                    const Text(
                      "Deposit",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    Consumer<TotalDeposit>( builder: (context, totalDrposit, child) =>  ItemPrice(textStyle:  const TextStyle(color: Colors.black54,fontSize: 14,fontWeight: FontWeight.bold), price: totalDeposit,)),

                  ],),],);
              },),

              SizedBox(height: size.width / 30),

              Row(children: const [
                Icon(Icons.warning_rounded,color: Colors.redAccent,size: 14,),
                SizedBox(width: 10,),
                Text(style: TextStyle(fontSize: 14,color: Colors.redAccent),"Shipping fee has not included! "),
              ],),
              SizedBox(height: size.width / 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      onPressed: ()  {
                        setState(() {
                          index=1;
                        });
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
            ]),
          )),
    );
  }

  Widget payment(BuildContext context,Size size,List<Cart> cartList){
    return Container(margin: EdgeInsets.symmetric(horizontal: size.width/15,vertical: size.width/15,),child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
      const Text(
        "Upload Payment Photo",
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black),
      ),
      SizedBox(height: size.width / 30),
      Row(
        children: [
          transferImage != null
              ? SizedBox(
                  width: size.width / 6,
                  height: size.width / 6,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        side: BorderSide(
                            width: 2, color: HexColor("8DA6FE"))),
                    onPressed: (() async {
                      transferImage = await openGallery();
                      setState(() {});
                    }),
                    child: Image.file(transferImage!),
                  ))
              : SizedBox(
                  width: size.width / 6,
                  height: size.width / 6,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: HexColor("8DA6FE")),
                    onPressed: (() async {
                      transferImage = await openGallery();
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
        height:size.height / 13,
        child: ElevatedButton(
            onPressed: () async {
              if (ktpImage == null || transferImage == null) {
                CoolAlert.show(context: context, type: CoolAlertType.error, text: "Please input correct information...");
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
                    deliveryLocation: _deliveryLocation,
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
    ],),);
  }

  Future<bool> wait () async{
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}

class TotalDeposit with ChangeNotifier {
  int _price =0;
  int _deposit =0;

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
