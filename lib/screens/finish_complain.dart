import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/screens/manage_complain_admin.dart';
import 'package:sporent/screens/minus_deposit.dart';
import 'package:sporent/screens/return_balance.dart';

class FinishComplain extends StatefulWidget {
  const FinishComplain(this.idTransaction, this.idComplain, {super.key});

  final String idTransaction;
  final String idComplain;

  @override
  State<FinishComplain> createState() => _FinishComplainState();
}

class _FinishComplainState extends State<FinishComplain> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Finish Complain"),
          ),
          backgroundColor: HexColor("4164DE"),
        ),
        resizeToAvoidBottomInset: false,
        body: Form(
            key: _formKey,
            child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: _size.height / 30, horizontal: _size.width / 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Conlusion Complain",
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
                          labelText: "Enter complain conclusion"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Conclusion must be filled";
                        } else {
                          return null;
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
                              FirebaseFirestore.instance
                                  .collection("complain")
                                  .doc(widget.idComplain)
                                  .update({
                                "status": "Complain Accepted",
                                "date": DateTime.now(),
                                "conclusion" : controller.text
                              });

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      MinusDeposit(widget.idTransaction)));
                            }
                          },
                          child: const Text(
                            "Minus Deposit",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )),
                    ),
                    SizedBox(height: _size.height / 20),
                    SizedBox(
                      width: _size.width,
                      height: _size.height / 14,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: HexColor("4164DE")),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              FirebaseFirestore.instance
                                  .collection("complain")
                                  .doc(widget.idComplain)
                                  .update({
                                "status": "Complain Accepted",
                                "date": DateTime.now(),
                                "conclusion" : controller.text
                              });

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ReturnBalance(widget.idTransaction)));
                            }
                          },
                          child: const Text("Return Balance & End Date",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16))),
                    ),
                    SizedBox(height: _size.height / 30),
                    SizedBox(
                      width: _size.width,
                      height: _size.height / 14,
                      child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              FirebaseFirestore.instance
                                  .collection("complain")
                                  .doc(widget.idComplain)
                                  .update({
                                "status": "Complain Declined",
                                "date": DateTime.now(),
                                "conclusion" : controller.text
                              });

                              FirebaseFirestore.instance
                                  .collection("transaction")
                                  .doc(widget.idTransaction)
                                  .update({"status": "ACTIVE"});

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const ManageComplain()));
                            }
                          },
                          child: Text(
                            "Cancel Complain",
                            style: TextStyle(
                                color: HexColor("4164DE"),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )),
                    ),
                  ],
                ))));
  }
}
