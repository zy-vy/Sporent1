import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sporent/component/condition_check.dart';

class ConditionCheckBeforeUser extends StatelessWidget {
  const ConditionCheckBeforeUser(this.idTransaction, this.imageCondition, this.textController, {super.key});

  final String idTransaction;
  final String imageCondition;
  final String textController;


  @override
  Widget build(BuildContext context) {
    return ConditionCheck(idTransaction, "Description Product",
        "Enter your product description", "Description", "Condition Check", imageCondition, textController);
  }
}
