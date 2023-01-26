import 'dart:io';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sporent/component/item_price.dart';
import 'package:sporent/model/order.dart';
// import 'package:sporent/screens/complainproduct.dart';
import 'package:sporent/viewmodel/order_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../component/image_full_screen.dart';
import '../model/complain.dart';
import '../model/complain_detail.dart';
import '../utils/colors.dart';
import 'complain_detail.dart';
import 'notif_complain.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final orderViewModel = OrderViewModel();

  var dateFormat = DateFormat('d MMMM ' 'yyyy');

  late double size;

  late Order order;

  late String currentState;

  File? beforeImage, afterImage;

  String? trackingLink;

  String? description;

  int counterComplain = 1;
  List<File?> listImagesComplain = [];
  File? imageComplain;
  File? imageTempComplain;
  final complainController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    order = widget.order;
    currentState = "detailOrder";
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size.width;
    Size _size = MediaQuery.of(context).size;

    Map<String, Widget> listWidget = {
      "detailOrder": orderDetail(),
      "submitOrder": submitOrder(),
      "completeOrder": completeOrder(),
      "complainOrder" : complainOrder(),
      // "complainDetailOrder": complainDetailOrder()
    };
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Detail Order"),
          ),
          backgroundColor: hexStringToColor("4164DE"),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: _size.height/40, bottom: _size.height/30),
          child: SingleChildScrollView(child: listWidget[currentState]!),
        ));
  }

  Widget orderDetail() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [

      Container(
          margin:
              EdgeInsets.symmetric( vertical: size / 25, horizontal: size / 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              heading("Booking period"),
              SizedBox(height: size/25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(dateFormat.format(order.startDate!)),
                  SizedBox(width: size/ 10),
                  const FaIcon(FontAwesomeIcons.arrowRight),
                  SizedBox(width: size/ 10),
                  Text(dateFormat.format(order.endDate!))
                ],
              )
            ],
          )),
      Divider(color: hexStringToColor("E0E0E0"), thickness: 2,indent: size/15, endIndent: 15,),

      Container(
        margin:
            EdgeInsets.symmetric(horizontal: size / 15, vertical: size / 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          heading("Detail product"),
          SizedBox(height: size/25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: size / 3,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(imageUrl: "${order.product?.img}",progressIndicatorBuilder: (context, url, progress) => SizedBox(width: size/10 ,child: const CircularProgressIndicator(),),),
                    // child: Icon(Icons.access_time)),
                  )
                ),
              ),
              SizedBox(
                width: size / 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(order.product?.name ?? "",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    SizedBox(height: size/35,),
                    Text("${order.quantity} day"),
                    SizedBox(height: size/35,),
                    const Text(
                      "total payment",
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(height: size/45,),
                    ItemPrice(
                      price: order.total!,
                      trail: false,
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
        ]),
      ),
      Divider(color: hexStringToColor("E0E0E0"), thickness: 2,indent: size/15, endIndent: 15,),

      Container(
        margin:
            EdgeInsets.symmetric(horizontal: size / 15, vertical: size / 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heading("Delivery information"),
            SizedBox(
              height: size / 20,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Expanded(child: Text("Courier")),
                Expanded(child: Text("${order.deliveryMethod}"))
              ],
            ),
            SizedBox(height: size/35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Expanded(child: Text("Recipient")),
                Expanded(child: Text(order.user?.name ?? ""))
              ],
            ),
            SizedBox(height: size/35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Expanded(child: Text("Address")),
                Expanded(child: Text(order.deliveryLocation ?? ""))
              ],
            ),
          ],
        ),
      ),
      conditionCheckOwner(),
      trackingCode(),
      conditionCheckUser(),
      returnTrackingCode(),
      // Divider(color: hexStringToColor("E0E0E0"), thickness: 2,indent: size/15, endIndent: 15,),
      SizedBox(
        height: size / 15,
      ),
      Column(
        children: [
          Container(
            margin: EdgeInsets.all(size/15),
            height: size/10,
            decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(5)),
            child: Center(child: Text("status: ${order.status}",style: const TextStyle(color: Colors.white),),),
          ),
        ],
      ),
      orderDetailButton()
    ]);
  }

  Widget orderDetailButton() {
    if (order.status == "CONFIRM") {
      return acceptDeclineButton();
    } else if (order.status == "ACCEPT") {
      return submitOrderButton();
    } else if (order.status == "DELIVER") {
      return complainButton();
    } else if (order.status == "ACTIVE") {
      return complainButton();
    } else if (order.status == "RETURN") {
      return finishComplainButton();
    } else if (order.status == "COMPLAIN") {
      return complainDetailButton();
    }
    return  const SizedBox();
  }

  Widget acceptDeclineButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: size / 15),
            height: size/6,
            child: ElevatedButton(

                onPressed: () {
                  CoolAlert.show(context: context, type: CoolAlertType.confirm, onConfirmBtnTap: () {
                    orderViewModel.acceptOrder(order);
                    Navigator.pop(context);
                    setState(() {
                      currentState = "submitOrder";
                    });
                  },);

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor("4164DE"),
                ),
                child: const Text("Accept Order", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18)))),
        Container(
            margin: EdgeInsets.symmetric(horizontal: size / 15),
            height: size/6,
            child: TextButton(
                onPressed: () {
                  // CoolAlert.show(context: context, type: CoolAlertType.success);
                  CoolAlert.show(context: context, type: CoolAlertType.confirm, onConfirmBtnTap: () {
                    orderViewModel.declineOrder(order);
                    // Fluttertoast.showToast(msg: "decline");
                    Navigator.pop(context);
                  },).then((value) {                  Navigator.pop(context);
                  });

                },

                child: Text("Decline Order", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,color: HexColor("4164DE")))))
      ],
    );
  }

  Widget submitOrderButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: size / 15),
            height: size/6,
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentState = "submitOrder";
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor("4164DE"),
                ),
                child: const Text("Submit Order Tracking", style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18)))),
      ],
    );
  }

  Widget finishComplainButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: size / 15),
            height: size/6,
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentState = "completeOrder";
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor("4164DE"),
                ),
                child: const Text("Finish Order", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18)))),
        complainButton()
      ],
    );
  }

  Widget complainButton(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: size / 15,vertical: size/15),
            height: size/6,
            child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ComplainProduct(FirebaseAuth.instance.currentUser!.uid, order.id!),));
                  setState(() {
                    currentState = "complainOrder";
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor("4164DE"),
                ),
                child: const Text("Complain Order", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18)))),
      ],
    );
  }

  Widget complainDetailButton () {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: size / 15),
            height: size/6,
            child: ElevatedButton(
                onPressed: () {
                  // setState(() {
                  //   currentState = "submitOrder";
                  // });
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailComplain(
                                order
                                    .complainRef!.id,
                                order.product!.name!,
                                order.product!.img!,
                                order.total!, "owner")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor("4164DE"),
                ),
                child: const Text("complain detail", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18)))),
      ],
    );
  }

  Widget submitOrder() {
    return Container(
      padding: EdgeInsets.fromLTRB(size / 15, size / 10, size / 15, size / 15),
      child: Column(
        children: [
          Container(
              // height: size/5,
              // decoration: BoxDecoration(border: Border.all()),
              margin: EdgeInsets.symmetric(
                  horizontal: size / 30, vertical: size / 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  heading("Please take a picture before sending item"),
                  SizedBox(
                    height: size / 20,
                  ),
                  Row(
                    children: [
                      beforeImage != null
                          ? Container(
                              width: size / 6,
                              height: size / 6,
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  side: BorderSide(
                                      width: 2,
                                      color: HexColor("868686")))),
                              child: TextButton(
                                // style: TextButton.styleFrom(
                                //     side: BorderSide(
                                //         width: 2, color: HexColor("FFFFFF"))),
                                onPressed: (() async {
                                  beforeImage = await openCamera();
                                  setState(() {});
                                }),
                                child: Image.file(beforeImage!),
                              ))
                          : Container(
                              width: size / 6,
                              height: size / 6,
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10),
                                side: BorderSide(
                                    width: 2,
                                    color: HexColor("868686")))),
                              child: TextButton(
                                // style: TextButton.styleFrom(
                                //     backgroundColor: HexColor("8DA6FE")),
                                onPressed: (() async {
                                  beforeImage = await openCamera();
                                  setState(() {});
                                }),
                                child: Center(
                                    child: FaIcon(FontAwesomeIcons.plus,
                                        color: HexColor("4164DE"), size: 30)),
                              ),
                            )
                    ],
                  ),
                  SizedBox(
                    height: size / 15,
                  ),
                  heading("Delivery information"),
                  SizedBox(
                    height: size / 20,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Expanded(child: Text("Courier")),
                      Expanded(child: Text("${order.deliveryMethod}"))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Expanded(child: Text("Recipient")),
                      Expanded(child: Text(order.user?.name ?? ""))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Expanded(child: Text("Address")),
                      Expanded(child: Text(order.deliveryLocation ?? ""))
                    ],
                  ),
                  SizedBox(
                    height: size / 15,
                  ),
                  heading("Submit order live tracking link"),
                  SizedBox(
                    height: size / 20,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Live tracking link"),
                    onChanged: (value) {
                      trackingLink = value;
                    },
                  ),
                  SizedBox(
                    height: size / 5,
                  ),
                  SizedBox(
                    height: size/6,
                    child: ElevatedButton(

                        onPressed: () {
                          if (beforeImage == null ||
                              trackingLink == null ||
                              trackingLink!.isEmpty) {
                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.error,
                                text:
                                    "Please input before photo and correct tracking link");
                            return;
                          }
                          orderViewModel
                              .submitOrder(order, beforeImage, trackingLink!)
                              .then((value) => value != false
                                  ? CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.success).then((value) => setState(() {
                            beforeImage = null;
                            currentState = "detailOrder";
                          }))
                                  : CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.error));

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor : HexColor("4164DE"),
                        ),
                        child: const Text("Submit", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget completeOrder() {
    return Container(
      padding: EdgeInsets.fromLTRB(size / 15, size / 10, size / 15, size / 15),
      child: Column(
        children: [
          Container(
              // height: size/5,
              // decoration: BoxDecoration(border: Border.all()),
              margin: EdgeInsets.symmetric(
                  horizontal: size / 30, vertical: size / 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  heading("Please take a picture of product"),
                  SizedBox(
                    height: size / 20,
                  ),
                  Row(
                    children: [
                      afterImage != null
                          ? Container(
                              width: size / 6,
                              height: size / 6,
                              decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      side: BorderSide(
                                          width: 2,
                                          color: HexColor("868686")))),
                              child: TextButton(
                                // style: TextButton.styleFrom(
                                //     side: BorderSide(
                                //         width: 2, color: HexColor("8DA6FE"))),
                                onPressed: (() async {
                                  afterImage = await openCamera();
                                  setState(() {});
                                }),
                                child: Image.file(afterImage!),
                              ))
                          : Container(
                              width: size / 6,
                              height: size / 6,
                              decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      side: BorderSide(
                                          width: 2,
                                          color: HexColor("868686")))),
                              child: TextButton(
                                // style: TextButton.styleFrom(
                                //     backgroundColor: HexColor("8DA6FE")),
                                onPressed: (() async {
                                  afterImage = await openCamera();
                                  setState(() {});
                                }),
                                child: Center(
                                    child: FaIcon(FontAwesomeIcons.plus,
                                        color: HexColor("4164DE"), size: 30)),
                              ),
                            )
                    ],
                  ),
                  SizedBox(
                    height: size / 15,
                  ),
                  heading("Product description"),
                  SizedBox(
                    height: size / 20,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Enter your product description"),
                    onChanged: (value) {
                      description = value;
                    },
                  ),
                  SizedBox(
                    height: size / 5,
                  ),
                  SizedBox(
                    height: size/6,
                    child: ElevatedButton(
                        onPressed: () {
                          if (afterImage == null || description == null) {
                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.error,
                                text:
                                    "please upload correct image and description");
                            return;
                          }
                          orderViewModel
                              .finishOrder(order, afterImage!, description!)
                              .then((value) => value != false
                                  ? CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.success)
                                  : CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.error));

                          setState(() {
                            afterImage = null;
                            currentState = "detailOrder";
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor : HexColor("4164DE"),
                        ),
                        child: const Text("Submit", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),

                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget complainOrder(){


    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: size/15,
          horizontal: size/15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Please take a picture of your product",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: size/30),
          Row(
            children: [
              for (int i = 0; i < counterComplain; i++)
                Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: size/6,
                          height: size/6,
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(8),
                                  side: BorderSide(
                                      width: 2,
                                      color: hexStringToColor(
                                          "868686")))),
                          child: TextButton(
                              onPressed: () async {
                                imageComplain = await openCamera();
                                setState(() {
                                  if (counterComplain >= 2) {
                                    listImagesComplain.remove(imageTempComplain);
                                  }

                                  listImagesComplain.add(imageComplain);

                                  if (counterComplain != 3) {
                                    listImagesComplain.add(imageTempComplain);
                                    counterComplain += 1;
                                  }
                                });
                              },
                              child: listImagesComplain.isEmpty == true
                                  ? FaIcon(
                                FontAwesomeIcons.plus,
                                color: hexStringToColor(
                                    "4164DE"),
                                size: 35,
                              )
                                  : listImagesComplain[i] != null
                                  ? Image.file(listImagesComplain[i]!)
                                  : FaIcon(
                                FontAwesomeIcons.plus,
                                color: hexStringToColor(
                                    "4164DE"),
                                size: 35,
                              )),
                        ),
                        listImagesComplain.isEmpty == true
                            ? const Positioned(
                            right: 0, top: 0, child: SizedBox())
                            : listImagesComplain[i] != null
                            ? Positioned(
                          right: 0,
                          child: Container(
                              height: 25,
                              width: 25,
                              decoration:
                              const BoxDecoration(
                                  color: Colors
                                      .blueAccent,
                                  shape: BoxShape
                                      .circle),
                              child: IconButton(
                                icon: const FaIcon(
                                    FontAwesomeIcons
                                        .xmark,
                                    size: 10,
                                    color: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    listImagesComplain.remove(
                                        listImagesComplain[i]);
                                    if (counterComplain != 1) {
                                      counterComplain -= 1;
                                    }
                                  });
                                },
                              )),
                        )
                            : const Positioned(
                            right: 0,
                            top: 0,
                            child: SizedBox())
                      ],
                    ),
                    counterComplain != 1
                        ? SizedBox(width: size / 20)
                        : const SizedBox(),
                  ],
                ),
            ],
          ),
          SizedBox(height: size / 15),
          const Text("Complain Description",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: size/30),
          TextFormField(
            controller: complainController,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 5,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Please describe your complain"),
            validator: (value) {
              if (value!.isEmpty) {
                return "Complain must be Filled";
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: size/5),
          SizedBox(
              width: size,
              height: size/6,
              child: ElevatedButton(
                onPressed: () {
                  uploadFile(listImagesComplain, order.id!,
                      complainController.text);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const NotifComplain()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: hexStringToColor("4164DE"),
                  // padding: const EdgeInsets.only(right: 300, bottom: 40)
                ),
                child: const Text("Complain Product",
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              )),
        ],
      ),
    );
  }

  Widget conditionCheckOwner(){
    if (order.status== "WAITING" || order.status == "CONFIRM" || order.status == "ACCEPT"){
      return const SizedBox();
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size/15,vertical: size/20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: hexStringToColor("E0E0E0"), thickness: 2),

          SizedBox(
            height: size / 15,
          ),
          heading("Condition check (Owner)"),
          SizedBox(
            height: size / 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              order.beforeOwnerFile != null
                  ? Container(
                  decoration: BoxDecoration(border: Border.all(width: 1,color: HexColor("E0E0E0")),borderRadius: BorderRadius.circular(8)),
                  width: size / 6,
                  height: size / 6,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => FullScreen(
                                  "firebaseImage", firebaseImage: order.beforePhotoOwner, filePath: "condition-check",)));
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(order.beforeOwnerFile!,fit: BoxFit.fill,)),
                  ))
                  : Container(
                  decoration: BoxDecoration(border: Border.all(width: 1,color: HexColor("E0E0E0")),borderRadius: BorderRadius.circular(8),color: HexColor("8DA6FE")),
                  width: size / 6,
                  height: size / 6,
                  child: const Icon(IconlyBold.infoSquare))
              ,
              order.afterOwnerFile != null
                  ? Container(
                  decoration: BoxDecoration(border: Border.all(width: 1,color: HexColor("E0E0E0")),borderRadius: BorderRadius.circular(8)),
                  width: size / 6,
                  height: size / 6,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => FullScreen(
                                  "firebaseImage", firebaseImage: order.afterPhotoOwner, filePath: "condition-check",)));
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(order.afterOwnerFile!,fit: BoxFit.fill,)),
                  ))
                  : const SizedBox()
              ,
            ],
          ),
        ],
      ),
    );
  }

  Widget trackingCode(){
    if (order.status== "WAITING" || order.status == "CONFIRM" || order.status == "ACCEPT"){
      return const SizedBox();
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size/15,vertical: size/20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: hexStringToColor("E0E0E0"), thickness: 2),
          SizedBox(
            height: size / 15,
          ),
          heading("Live tracking code"),
          SizedBox(
            height: size / 20,
          ),

          // TextFormField(
          //
          //   decoration:  const InputDecoration(
          //       border: OutlineInputBorder(),
          //
          //   ),
          //   readOnly: true,
          //   initialValue: order.trackingCode??"",
          // ),
          TextButton(onPressed: () async {
            final uri = Uri.parse("${order.trackingCode}");
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            } else {
              throw 'Could not launch $uri';
            }
          }, child: Text(order.trackingCode??""))
        ],
      ),
    );
  }

  Widget conditionCheckUser(){
    if (order.status== "WAITING" || order.status == "CONFIRM"||order.status =="DELIVER"  || order.status == "ACCEPT"){
      return const SizedBox();
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size/15,vertical: size/20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: hexStringToColor("E0E0E0"), thickness: 2),
          SizedBox(
            height: size / 15,
          ),
          heading("Condition check (User)"),
          SizedBox(
            height: size / 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              order.beforeUserFile != null
                  ? Container(
                  decoration: BoxDecoration(border: Border.all(width: 1,color: HexColor("E0E0E0")),borderRadius: BorderRadius.circular(8)),
                  width: size / 6,
                  height: size / 6,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => FullScreen(
                                  "firebaseImage", firebaseImage: order.beforePhotoUser,filePath: "condition-check",)));
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(order.beforeUserFile!,fit: BoxFit.fill,)),
                  ))
                  : const SizedBox()
              ,
              order.afterUserFile != null
                  ? Container(
                  decoration: BoxDecoration(border: Border.all(width: 1,color: HexColor("E0E0E0")),borderRadius: BorderRadius.circular(8)),
                  width: size / 6,
                  height: size / 6,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => FullScreen(
                                  "firebaseImage", firebaseImage:order.afterPhotoUser, filePath: "condition-check",)));
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(order.afterUserFile!,fit: BoxFit.fill,)),
                  ))
                  : const SizedBox()
              ,
            ],
          ),
        ],
      ),
    );
  }

  Widget returnTrackingCode(){
    if (order.status== "WAITING" || order.status == "CONFIRM"||order.status =="DELIVER" || order.status == "ACCEPT"){
      return const SizedBox();
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size/15,vertical: size/20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: HexColor("E0E0E0"), thickness: 2),
          SizedBox(
            height: size / 15,
          ),
          heading("Return tracking code"),
          SizedBox(
            height: size / 20,
          ),

          // TextFormField(
          //
          //   decoration:  const InputDecoration(
          //     border: OutlineInputBorder(),
          //
          //   ),
          //   readOnly: true,
          //   initialValue: order.returnTrackingCode??"",
          // ),
          // RichText(text: TextSpan(
          //   children: [TextSpan(
          //     style: const TextStyle(color: Colors.blueAccent),
          //       text: order.returnTrackingCode??"asdf",
          //       recognizer: TapGestureRecognizer()
          //         ..onTap = () async {
          //          final uri = Uri.parse(order.returnTrackingCode??"");
          //                     if (await canLaunchUrl(uri)) {
          //                       await launchUrl(uri,mode:  LaunchMode.inAppWebView);
          //                     } else {
          //                       throw 'Could not launch $uri';
          //                     }
          //         }
          //
          //   )]
          // ))
          TextButton(onPressed: () async {
            final uri = Uri.parse("${order.returnTrackingCode}");
            if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
            } else {
            throw 'Could not launch $uri';
            }
          }, child: Text(order.returnTrackingCode??""))
        ],
      ),
    );
  }

  Text heading(String title) => Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      );

  Future<File?> openCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.camera);
    return File(imagePicked!.path);
  }

  Future uploadFile(
      List<File?> listImages, String id, String complainController) async {
    final refcomplain = FirebaseFirestore.instance.collection('complain').doc();
    final List<String> _arrImageUrls = [];
    for (int i = 0; i < listImages.length; i++) {
      if (listImages[i]==null) continue;
      Reference reference = FirebaseStorage.instance
          .ref()
          .child('complain-images/${refcomplain.id + i.toString()}');
      await reference.putFile(listImages[i]!);
      String urlImage = await reference.getDownloadURL();
      _arrImageUrls.add(urlImage);
    }

    final complain = Complain(
        status: "In Progress",
        transaction:
        FirebaseFirestore.instance.collection("transaction").doc(id))
        .toJSON();

    await refcomplain.set(complain).onError((error, stackTrace) => log("$error , $stackTrace"));

    final complainDetail = ComplainDetail(
        date: DateTime.now(),
        description: complainController,
        image: _arrImageUrls,
        complain: refcomplain)
        .toJSON();

    await FirebaseFirestore.instance
        .collection("complain_detail")
        .doc()
        .set(complainDetail).onError((error, stackTrace) => log("$error , $stackTrace"));

    FirebaseFirestore.instance
        .collection("transaction")
        .doc(id)
        .update({"complain": refcomplain, "status" : "COMPLAIN"}).onError((error, stackTrace) => log("$error , $stackTrace"));
  }

}
