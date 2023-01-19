import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TermsCondition extends StatelessWidget {
  const TermsCondition({super.key});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
          child: const Text("Terms and Condition"),
        ),
        backgroundColor: HexColor("4164DE"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
                  vertical: _size.height / 30, horizontal: _size.width / 18),
        child: ListView(
          children: [
            title("Terms and Condition for Sporent", _size),
            description(
                "Users in this case, Sporent Owner are subject to the Privacy Policy and Terms and Conditions written below. Users are advised to read carefully because it can affect the legal rights and obligations of users.", _size),
            description("By registering and/or using Sporent, the User is deemed to have read, understood, understood and agreed to all contents in these Terms and Conditions. These Terms and Conditions are a form of agreement set forth in a valid agreement between the User and Sporent. If the User does not agree to one, part, or all of the contents of the Terms and Conditions, then the User is not allowed to become the owner of the goods in Sporent", _size),
            title("Definition", _size),
            description("Sporent is a platform that connects people who want to borrow goods with the owner of an item. User is a term for people who want to borrow goods. Owner is a term for people who want to lend goods to other people. Privacy Policy, these Terms and Conditions and any other terms and conditions that may apply to or in connection with the use of the Site/Application and all the features contained therein.", _size),
            title("Become Owner", _size),
            description("To be able to become an owner at Sporent, a user needs to fill in some information and agree to the terms and conditions that apply to the Sporent application and to become an owner. Users also agree to provide information to Sporent to process the information and use it for the common good. The owner is also expected to be honest and follow existing procedures by delivering goods correctly and according to what is displayed and not committing fraud. If fraud occurs, the owner's account can be suspended and reported to court", _size),
            title("Transaction", _size),
            description("There is a deposit and condition check system that prevents items from being lost in the Sporent application with the price of goods and deposits being determined by the owner himself. In the event of loss of goods or exchange of goods, Sporent will become a third party to investigate fraud that occurs using evidence obtained from the condition check feature and others. If it is proven that there has been fraud on the part of the user, then the deposit will be deducted according to the damage and fraud that has occurred", _size)
          ],
        ),
      ),
    );
  }
}

Column title(String text, Size _size) => Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: _size.height / 60),
      ],
    );

Column description(String text, Size _size) => Column(
      children: [
        Text(text,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
            )),
        SizedBox(height: _size.height / 60),
      ],
    );
