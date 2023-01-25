import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sporent/component/firebase_image.dart';

import '../component/image_full_screen.dart';
import '../component/item_price.dart';
import '../model/order.dart';
import '../viewmodel/order_viewmodel.dart';

class AdminOrderScreen extends StatefulWidget {
  const AdminOrderScreen({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  State<AdminOrderScreen> createState() => _AdminDetailScreenState();
}

class _AdminDetailScreenState extends State<AdminOrderScreen> {
  final orderViewModel = OrderViewModel();

  var dateFormat = DateFormat('dd-MM-yyyy');

  late double size;

  late Order order;

  late String currentState;

  File? beforeImage, afterImage;

  String? trackingLink;

  String? description;

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

    Map<String, Widget> listWidget = {
      "detailOrder": orderDetail(),
      "submitOrder": submitOrder(),
      "completeOrder": completeOrder(),
      // "acceptPayment" : acceptPayment()
    };
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Detail Transaction"),
          ),
          backgroundColor: HexColor("4164DE"),
        ),
        body: SingleChildScrollView(child: listWidget[currentState]!));
  }

  Widget orderDetail() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [

      Container(

          margin:
          EdgeInsets.symmetric( vertical: size / 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              heading("Booking period"),
              SizedBox(height: size/25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(dateFormat.format(order.startDate!)),
                  const FaIcon(FontAwesomeIcons.arrowRight),
                  Text(dateFormat.format(order.endDate!))
                ],
              )
            ],
          )),
      Divider(color: HexColor("E0E0E0"), thickness: 2,indent: size/15, endIndent: 15,),

      Container(
        margin:
        EdgeInsets.symmetric(horizontal: size / 15, vertical: size / 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          heading("Detail product"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: size / 3,
                child: CachedNetworkImage(imageUrl: "${order.product!.img}",)
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
                    Text("${order.quantity} day"),
                    const Text(
                      "total payment",
                      style: TextStyle(color: Colors.black54),
                    ),
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
      Divider(color: HexColor("E0E0E0"), thickness: 2,indent: size/15, endIndent: 15,),
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
          ],
        ),
      ),
      Divider(color: HexColor("E0E0E0"), thickness: 2,indent: size/15, endIndent: 15,),
      Container(
        margin: EdgeInsets.all(size/15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heading("KTP"),
            SizedBox(height: size/20,),
            order.ktpImage!= null ? Container(
                decoration: BoxDecoration(border: Border.all(width: 1,color: HexColor("E0E0E0")),borderRadius: BorderRadius.circular(8)),
                width: size / 6,
                height: size / 6,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => FullScreen(
                                "",order.ktpImage!,location: "ktp",)));
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: FirebaseImage(filePath: "ktp/${order.ktpImage!}",)),
                )):const Text("Ktp image not found !"),
          ],
        ),
      ),
      Divider(color: HexColor("E0E0E0"), thickness: 2,indent: size/15, endIndent: 15,),
      Container(
        margin: EdgeInsets.all(size/15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heading("Payment"),
            SizedBox(height: size/20,),
            order.paymentImage != null ? Container(
                decoration: BoxDecoration(border: Border.all(width: 1,color: HexColor("E0E0E0")),borderRadius: BorderRadius.circular(8)),
                width: size / 6,
                height: size / 6,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => FullScreen(
                                "", order.paymentImage, location: "payment",)));
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: FirebaseImage(filePath: "payment/${order.paymentImage!}",)),
                )):const Text("Ktp image not found !"),

          ],
        ),
      ),
      Divider(color: HexColor("E0E0E0"), thickness: 2,indent: size/15, endIndent: 15,),

      // conditionCheckOwner(),
      // trackingCode(),
      // conditionCheckUser(),
      // returnTrackingCode(),
      // Divider(color: hexStringToColor("E0E0E0"), thickness: 2,indent: size/15, endIndent: 15,),
      SizedBox(
        height: size / 10,
      ),
      orderDetailButton(),
      SizedBox(
        height: size/15,
      ),
    ]);
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
                          ? SizedBox(
                          width: size / 6,
                          height: size / 6,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                side: BorderSide(
                                    width: 2, color: HexColor("8DA6FE"))),
                            onPressed: (() async {
                              beforeImage = await openGallery();
                              setState(() {});
                            }),
                            child: Image.file(beforeImage!),
                          ))
                          : SizedBox(
                        width: size / 6,
                        height: size / 6,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: HexColor("8DA6FE")),
                          onPressed: (() async {
                            beforeImage = await openGallery();
                            setState(() {});
                          }),
                          child: const Center(
                              child: FaIcon(FontAwesomeIcons.plus,
                                  color: Colors.white, size: 30)),
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
                  ElevatedButton(
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
                      child: const Text("Submit"))
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
                  heading("Please take a picture before sending item"),
                  SizedBox(
                    height: size / 20,
                  ),
                  Row(
                    children: [
                      afterImage != null
                          ? SizedBox(
                          width: size / 6,
                          height: size / 6,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                side: BorderSide(
                                    width: 2, color: HexColor("8DA6FE"))),
                            onPressed: (() async {
                              afterImage = await openGallery();
                              setState(() {});
                            }),
                            child: Image.file(afterImage!),
                          ))
                          : SizedBox(
                        width: size / 6,
                        height: size / 6,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: HexColor("8DA6FE")),
                          onPressed: (() async {
                            afterImage = await openGallery();
                            setState(() {});
                          }),
                          child: const Center(
                              child: FaIcon(FontAwesomeIcons.plus,
                                  color: Colors.white, size: 30)),
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
                  ElevatedButton(
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
                      child: const Text("Submit"))
                ],
              )),
        ],
      ),
    );
  }

  Widget orderDetailButton() {
    if (order.status == "WAITING"){
      return acceptPaymentButton();
    }
    // else if (order.status == "CONFIRM") {
    //   return acceptDeclineButton();
    // } else if (order.status == "ACCEPT") {
    //   return submitOrderButton();
    // }  else if (order.status == "ACTIVE") {
    //   return finishComplainButton();
    // } else if (order.status == "RETURN") {
    //   return finishComplainButton();
    // }
    return  Container(
      margin: EdgeInsets.fromLTRB(size/15,0,size/15,size/10),
      height: size/10,
      decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(5)),
      child: Center(child: Text(order.status??"",style: const TextStyle(color: Colors.white),),),
    );
  }

  Widget acceptPaymentButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: size / 15),
            height: size/6,
            child: ElevatedButton(
                onPressed: () {
                  CoolAlert.show(context: context, type: CoolAlertType.confirm,onConfirmBtnTap: () {
                    orderViewModel.acceptPayment(order);
                    CoolAlert.show(context: context, type: CoolAlertType.success).then((value) {
                      setState(() {

                      });
                      Navigator.pop(context);
                    });
                  },);

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor("4164DE"),
                ),
                child: const Text("Accept Payment",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),))),
        SizedBox(height: size/15,),
        Container(
            margin: EdgeInsets.symmetric(horizontal: size / 15),
            height: size/6,
            child: ElevatedButton(
                onPressed: () {
                  CoolAlert.show(context: context, type: CoolAlertType.confirm,onConfirmBtnTap: () {
                    orderViewModel.rejectPayment(order);
                    CoolAlert.show(context: context, type: CoolAlertType.success).then((value)  {
                      setState(() {

                      });
                      Navigator.pop(context);
                    });
                  },);


                  // Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor("4164DE"),
                ),
                child: const Text("Reject Payment",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)))
      ],
    );
  }

  Widget acceptDeclineButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: size / 15),
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentState = "submitOrder";
                  });
                },
                child: const Text("Accept Order"))),
        Container(
            margin: EdgeInsets.symmetric(horizontal: size / 15),
            child: ElevatedButton(
                onPressed: () {
                  orderViewModel.declineOrder(order);
                  CoolAlert.show(context: context, type: CoolAlertType.success);
                  Navigator.pop(context);
                }, child: const Text("Decline Order")))
      ],
    );
  }

  Widget submitOrderButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: size / 15),
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentState = "submitOrder";
                  });
                },
                child: const Text("Submit Order Tracking"))),
      ],
    );
  }

  Widget finishComplainButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: size / 15),
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentState = "completeOrder";
                  });
                },
                child: const Text("Finish Order"))),
        Container(
            margin: EdgeInsets.symmetric(horizontal: size / 15),
            child: ElevatedButton(
                onPressed: () {}, child: const Text("Complain Order")))
      ],
    );
  }

  Widget conditionCheckOwner(){
    // if (order.status== "WAITING" || order.status == "CONFIRM"){
    //   return const SizedBox();
    // }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size/15,vertical: size/20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: HexColor("E0E0E0"), thickness: 2),

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
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(order.beforeOwnerFile!,fit: BoxFit.fill,)))
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
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(order.afterOwnerFile!,fit: BoxFit.fill,)))
                  : Container(
                  decoration: BoxDecoration(border: Border.all(width: 1,color: HexColor("E0E0E0")),borderRadius: BorderRadius.circular(8),color: HexColor("8DA6FE")),
                  width: size / 6,
                  height: size / 6,
                  child: const Icon(IconlyBold.infoSquare))
              ,
            ],
          ),
        ],
      ),
    );
  }

  Widget trackingCode(){
    // if (order.status== "WAITING" || order.status == "CONFIRM"){
    //   return const SizedBox();
    // }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size/15,vertical: size/20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: HexColor("E0E0E0"), thickness: 2),
          SizedBox(
            height: size / 15,
          ),
          heading("Live tracking code"),
          SizedBox(
            height: size / 20,
          ),

          TextFormField(

            decoration:  const InputDecoration(
              border: OutlineInputBorder(),

            ),
            readOnly: true,
            initialValue: order.trackingCode??"",
          ),
        ],
      ),
    );
  }

  Widget conditionCheckUser(){
    // if (order.status== "WAITING" || order.status == "CONFIRM"||order.status =="DELIVER"){
    //   return const SizedBox();
    // }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size/15,vertical: size/20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: HexColor("E0E0E0"), thickness: 2),
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
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(order.beforeUserFile!,fit: BoxFit.fill,)))
                  : Container(
                  decoration: BoxDecoration(border: Border.all(width: 1,color: HexColor("E0E0E0")),borderRadius: BorderRadius.circular(8),color: HexColor("8DA6FE")),
                  width: size / 6,
                  height: size / 6,
                  child: const Icon(IconlyBold.infoSquare))
              ,
              order.afterUserFile != null
                  ? Container(
                  decoration: BoxDecoration(border: Border.all(width: 1,color: HexColor("E0E0E0")),borderRadius: BorderRadius.circular(8)),
                  width: size / 6,
                  height: size / 6,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(order.afterUserFile!,fit: BoxFit.fill,)))
                  : Container(
                  decoration: BoxDecoration(border: Border.all(width: 1,color: HexColor("E0E0E0")),borderRadius: BorderRadius.circular(8),color: HexColor("8DA6FE")),
                  width: size / 6,
                  height: size / 6,
                  child: const Icon(IconlyBold.infoSquare))
              ,
            ],
          ),
        ],
      ),
    );
  }

  Widget returnTrackingCode(){
    // if (order.status== "WAITING" || order.status == "CONFIRM"||order.status =="DELIVER"){
    //   return const SizedBox();
    // }
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

          TextFormField(

            decoration:  const InputDecoration(
              border: OutlineInputBorder(),

            ),
            readOnly: true,
            initialValue: order.returnTrackingCode??"",
          ),
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

  Future<File?> openGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
    await picker.pickImage(source: ImageSource.gallery);
    return File(imagePicked!.path);
  }
}
