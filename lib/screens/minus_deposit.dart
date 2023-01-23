import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/screens/manage_complain_admin.dart';

class MinusDeposit extends StatefulWidget {
  const MinusDeposit(this.id, {super.key});

  final String id;

  @override
  State<MinusDeposit> createState() => _MinusDepositState();
}

class _MinusDepositState extends State<MinusDeposit> {
  final TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Minus Deposit"),
          ),
          backgroundColor: HexColor("4164DE"),
        ),
        resizeToAvoidBottomInset: true,
        body: Form(
            key: _formKey,
            child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: _size.height / 30, horizontal: _size.width / 18),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("transaction")
                        .doc(widget.id)
                        .snapshots(),
                    builder: (context, snapshot) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Minus Deposit",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          SizedBox(height: _size.height / 50),
                          TextFormField(
                            controller: controller,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 5,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Enter deposit"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Deposit must be filled";
                              }
                              if (int.parse(value) >
                                  snapshot.data!.get("deposit")) {
                                return "Nominal must less than deposit";
                              }
                            },
                          ),
                          SizedBox(height: _size.height / 30),
                          SizedBox(
                            width: _size.width,
                            height: _size.height / 14,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: HexColor("4164DE")),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    int dataMinus =
                                        snapshot.data!.get("deposit") -
                                            int.parse(controller.text);

                                    FirebaseFirestore.instance
                                        .collection("transaction")
                                        .doc(widget.id)
                                        .update({"deposit": dataMinus, "status" : "ACTIVE"});

                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ManageComplain()));
                                  }
                                },
                                child: const Text(
                                  "Confirm",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )),
                          )
                        ],
                      );
                    }))));
  }
}
