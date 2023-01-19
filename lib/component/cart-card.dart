import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class CartCard extends StatefulWidget {
  const CartCard(this.lineOrNot, {super.key});

  final bool lineOrNot;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/tennis-racket.png',
              height: _size.height / 6,
              width: _size.width / 3,
            ),
            SizedBox(width: _size.width / 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Raket Tenis",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                SizedBox(height: _size.height / 90),
                const Text("Rp 150.000/Day",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: _size.height / 90),
                Text("How many day",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: HexColor("969696"))),
                SizedBox(height: _size.height / 95),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: HexColor("416DDE"),
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (counter > 0) {
                                counter--;
                              }
                            });
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.minus,
                            color: Colors.white,
                            size: 20,
                          )),
                    ),
                    SizedBox(width: _size.width / 30),
                    Text(
                      "$counter",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: _size.width / 30),
                    CircleAvatar(
                      backgroundColor: HexColor("416DDE"),
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              counter++;
                            });
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.plus,
                            color: Colors.white,
                            size: 20,
                          )),
                    ),
                    SizedBox(width: _size.width / 20),
                    IconButton(
                        onPressed: () {
                          showDeleteButton(context);
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.trash,
                          color: HexColor("808080"),
                        ))
                  ],
                )
              ],
            )
          ],
        ),
        widget.lineOrNot == true
            ? divider(_size)
            : SizedBox(height: _size.height / 20),
      ],
    );
  }
}

Column divider(Size _size) => Column(
      children: [
        SizedBox(height: _size.height / 40),
        Divider(color: HexColor("E6E6E6"), thickness: 3),
        SizedBox(height: _size.height / 40)
      ],
    );

showDeleteButton(BuildContext context) {
  Size _size = MediaQuery.of(context).size;

  Widget confirmButton = SizedBox(
    width: _size.width,
    height: _size.height / 20,
    child: ElevatedButton(
      onPressed: () {
        // final product = FirebaseFirestore.instance
        //     .collection('product-renter')
        //     .doc(deleteObject['id']);

        // product.delete();

        // final ref = FirebaseStorage.instance
        //     .ref()
        //     .child('product-images/')
        //     .child(deleteObject['id']);

        // ref.delete();

        // Navigator.of(context).pop();
      },
      style: ElevatedButton.styleFrom(backgroundColor: HexColor("4164DE")),
      child: const Text("Confirm",
          style: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
    ),
  );

  Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(
        "Cancel",
        style: TextStyle(
            fontSize: 16,
            color: HexColor("747272"),
            fontWeight: FontWeight.bold),
      ));

  AlertDialog alert = AlertDialog(
    contentPadding: EdgeInsets.symmetric(
        vertical: _size.height / 70, horizontal: _size.width / 20),
    alignment: Alignment.center,
    title: const Center(
      child: Text(
        "Delete Product?",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    ),
    content: Text(
      "Are you sure want to delete product?",
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w400, color: HexColor("979797")),
    ),
    actions: [
      Column(
        children: [confirmButton, cancelButton],
      )
    ],
    actionsAlignment: MainAxisAlignment.spaceAround,
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}
