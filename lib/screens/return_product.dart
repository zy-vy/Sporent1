import 'package:flutter/material.dart';
import 'package:sporent/component/condition_check.dart';

class ReturnProduct extends StatelessWidget {
  const ReturnProduct(
      this.idTransaction, this.imageCondition, this.textController,
      {super.key, this.idOwner});
  final String? idOwner;
  final String? idTransaction;
  final String? imageCondition;
  final String? textController;
  // final String? product_name;
  // final String? product_image;
  // final int? total;
  // final String? idUser;
  // final String? idProduct;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return ConditionCheck(
      idTransaction,
      "Live Tracking Online Driver Link",
      "Enter your online driver link",
      "Tracking Code",
      idOwner == "" ? "Condition Check After" : "Return Product",
      imageCondition,
      textController,
      idOwner: idOwner,
      // product_name: product_name,
      // product_image: product_image,
      // total: total,
      // idUser: idUser,
      // idProduct: idProduct,
    );
  }
}
