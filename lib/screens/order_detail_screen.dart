import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sporent/component/item_price.dart';
import 'package:sporent/model/order.dart';
import 'package:sporent/viewmodel/order_viewmodel.dart';

import '../component/firebase_image.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final orderViewModel = OrderViewModel();

  var dateFormat = DateFormat('dd-MM-yyyy');

  late double size;

  late Order order;

  late String currentState;

  File? beforeImage,afterImage;

  String? trackingLink;

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
      "completeOrder": completeOrder()
    };
    return Scaffold(body: SingleChildScrollView(child: listWidget[currentState]!));
  }

  Widget orderDetail() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SizedBox(
        height: size / 10,
      ),
      Container(
          height: size / 5,
          // decoration: BoxDecoration(border: Border.all()),
          margin: EdgeInsets.symmetric(
              horizontal: size / 30, vertical: size / 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              heading("Booking period"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(dateFormat.format(order.startDate!)),
                  const Text(" => "),
                  Text(dateFormat.format(order.endDate!))
                ],
              )
            ],
          )),
      const Divider(
        height: 0,
        thickness: 3,
        color: Colors.black38,
        indent: 20,
        endIndent: 20,
      ),
      Container(
        margin:
            EdgeInsets.symmetric(horizontal: size / 15, vertical: size / 20),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          heading("Detail product"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: size / 3,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.file(order.product!.imageFile!)),
                  // child: Icon(Icons.access_time)),
                ),
              ),
              SizedBox(
                width: size / 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        // decoration: BoxDecoration(border: Border.all()),
                        child: Text(order.product?.name ?? "",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis)),
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
      const Divider(
        height: 0,
        thickness: 3,
        color: Colors.black38,
        indent: 20,
        endIndent: 20,
      ),

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
      // const Divider(height: 0,thickness: 3,color: Colors.black38,indent: 20,endIndent: 20,),
      SizedBox(
        height: size / 10,
      ),
      orderDetailButton()
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
                    onChanged: (value) { trackingLink = value;},
                  ),
                  SizedBox(
                    height: size / 5,
                  ),
                  ElevatedButton(onPressed: () {
                    if (beforeImage==null || trackingLink==null || trackingLink!.isEmpty){
                      CoolAlert.show(context: context, type: CoolAlertType.error,text: "Please input before photo and correct tracking link");
                      return;
                    }
                    CoolAlert.show(context: context, type: CoolAlertType.success,text: "Success").then((value) {
                      setState(() {
                        currentState = "detailOrder";

                      });
                    });
                      setState(() {
                        currentState = "detailOrder";
                      });
                      beforeImage = null;
                  }, child: const Text("Submit"))
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
                        labelText: "Enter your product description"),
                    onChanged: (value) {  },
                  ),
                  SizedBox(
                    height: size / 5,
                  ),
                  ElevatedButton(onPressed: () {



                    afterImage = null;
                  }, child: const Text("Submit"))
                ],
              )),
        ],
      ),
    );
  }

  Widget orderDetailButton() {
    if(order.status == "CONFIRM"){
      return acceptDeclineButton();

    }
    else if (order.status == "ACCEPT"){
      return submitOrderButton();
    }
    else if (order.status == "RETURN"){
      return finishComplainButton();
    }
    return const SizedBox();
  }

  Widget acceptDeclineButton(){
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
                onPressed: () {}, child: const Text("Decline Order")))
      ],
    );
  }

  Widget submitOrderButton(){
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

  Widget finishComplainButton(){
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
