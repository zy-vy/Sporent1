import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/model/balance.dart';
import 'package:sporent/model/request.dart';
import 'package:sporent/screens/add_product.dart';
import 'package:sporent/screens/deposit-information.dart';

import '../component/edit_page.dart';
import '../component/loading.dart';
import '../model/deposit.dart';

class CashoutScreen extends StatefulWidget {
  const CashoutScreen(this.type, this.pageNext, this.saldo, this.id,
      {super.key});

  final String type;

  final Widget pageNext;

  final int saldo;

  final String id;

  @override
  State<CashoutScreen> createState() => _CashoutScreenState();
}

class _CashoutScreenState extends State<CashoutScreen> {
  final accountNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String field = "deposit";
  String field2 = "deposit";
  bool loading = false;
  String? bankName;
  List<DropdownMenuItem> bankItem = const [
    DropdownMenuItem(
      value: "Mandiri",
      child: Text("Mandiri"),
    ),
    DropdownMenuItem(
      value: "BRI",
      child: Text("BRI"),
    ),
    DropdownMenuItem(
      value: "BNI",
      child: Text("BNI"),
    ),
    DropdownMenuItem(
      value: "Panin Bank",
      child: Text("Panin Bank"),
    ),
    DropdownMenuItem(
      value: "BCA",
      child: Text("BCA"),
    ),
    DropdownMenuItem(
      value: "CIMB Niaga",
      child: Text("CIMB Niaga"),
    ),
    DropdownMenuItem(
      value: "Permata",
      child: Text("Permata"),
    ),
    DropdownMenuItem(
      value: "OCBC NISP",
      child: Text("OCBC NISP"),
    ),
    DropdownMenuItem(
      value: "BTPN",
      child: Text("BTPN"),
    ),
    DropdownMenuItem(
      value: "NOBU",
      child: Text("NOBU"),
    ),
    DropdownMenuItem(
      value: "DBS",
      child: Text("DBS"),
    ),
    DropdownMenuItem(
      value: "Mega",
      child: Text("Mega"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: Transform(
                transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
                child: Text("Get ${widget.type}"),
              ),
              backgroundColor: HexColor("4164DE"),
            ),
            resizeToAvoidBottomInset: true,
            body: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: _size.height / 30,
                        horizontal: _size.width / 18),
                    child: ListView(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Bank Name",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          SizedBox(height: _size.height / 50),
                          DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Enter your bank name'),
                              items: bankItem,
                              validator: (value) {
                                if (value == null) {
                                  return "Bank Name must not be empty";
                                }
                              },
                              onChanged: (value) => setState(() {
                                    bankName = value!;
                                  })),
                          SizedBox(height: _size.height / 23),
                          fieldText("Account Name", "Enter your account name",
                              _size, accountNameController),
                          fieldText(
                              "Account Number",
                              "Enter your account number",
                              _size,
                              accountNumberController),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Amount",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: _size.height / 50),
                              TextFormField(
                                controller: amountController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Enter amount"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Amount must not be empty";
                                  }
                                  if (int.parse(value) > widget.saldo) {
                                    return "Amount must less than ${widget.type}";
                                  }
                                },
                              ),
                              SizedBox(height: _size.height / 23),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(height: _size.height / 40),
                              SizedBox(
                                  width: _size.width,
                                  height: _size.height / 15,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          loading = true;
                                        });
                                        if (widget.type == "Balance") {
                                          field = "balance";
                                          field2 = "owner_balance";
                                        }

                                        var document = firestore
                                            .collection("user")
                                            .doc(widget.id);

                                        int amount =
                                            int.parse(amountController.text);
                                        var request = Request(
                                                id: widget.id,
                                                account_name:
                                                    accountNameController.text,
                                                account_number:
                                                    accountNumberController
                                                        .text,
                                                amount: amount,
                                                bank_name: bankName,
                                                date: DateTime.now(),
                                                status: "In Progress",
                                                type: field,
                                                name_request: firestore
                                                    .collection("user")
                                                    .doc(widget.id))
                                            .toJson();

                                        var documentRequest = firestore
                                            .collection("request")
                                            .doc();
                                        await documentRequest.set(request);

                                        if (widget.type == "Balance") {
                                          var balance = Balance(
                                                  id: widget.id,
                                                  amount: amount,
                                                  date: DateTime.now(),
                                                  owner: document,
                                                  status: "minus",
                                                  detail_id: firestore
                                                      .collection("request")
                                                      .doc(documentRequest.id))
                                              .toJson();
                                          await firestore
                                              .collection("balance")
                                              .doc()
                                              .set(balance);
                                        } else {
                                          var deposit = Deposit(
                                                  id: widget.id,
                                                  amount: amount,
                                                  date: DateTime.now(),
                                                  user: document,
                                                  status: "minus",
                                                  detail_id: firestore
                                                      .collection("request")
                                                      .doc(documentRequest.id))
                                              .toJson();

                                          await firestore
                                              .collection("deposit")
                                              .doc()
                                              .set(deposit);
                                        }

                                        await firestore
                                            .collection("user")
                                            .doc(widget.id)
                                            .update({
                                          field2: widget.saldo - amount
                                        });

                                        CoolAlert.show(
                                                context: context,
                                                type: CoolAlertType.success,
                                                text: "Success make request...")
                                            .then((value) =>
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        widget.pageNext,
                                                  ),
                                                ));
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: HexColor("4164DE"),
                                    ),
                                    child: const Text("Confirm",
                                        textAlign: TextAlign.center),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ]))));
  }
}
