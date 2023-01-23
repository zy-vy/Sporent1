import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporent/component/condition_check.dart';

class FinishComplain extends StatelessWidget {
  const FinishComplain(this.idTransaction, this.idUser, this.idOwner, this.idComplain, {super.key});

  final String idTransaction;
  final String idUser;
  final String idOwner;
  final String idComplain;

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    Size _size = MediaQuery.of(context).size;
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Transform(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child: const Text("Finish Complain"),
          ),
          backgroundColor: HexColor("4164DE"),
        ),
        resizeToAvoidBottomInset: true,
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
                            if (_formKey.currentState!.validate()) {}
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
                            if (_formKey.currentState!.validate()) {}
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
                            if (_formKey.currentState!.validate()) {}
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
