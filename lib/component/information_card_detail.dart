import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../model/balance.dart';
import '../model/deposit.dart';
import '../model/request.dart';

class DetailInformationCard extends StatelessWidget {
  const DetailInformationCard(this.showLine, this.type, 
      {super.key, this.deposit, this.balance, this.request});

  final bool showLine;

  final String type;

  final Deposit? deposit;

  final Balance? balance;

  final Request? request;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    var dateFormat = DateFormat('d MMMM ' 'yyyy');
    NumberFormat currencyFormatter =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

    return DecoratedBox(
      decoration: BoxDecoration(
          border: showLine == true
              ? Border(top: BorderSide(color: HexColor("CCCCCC"), width: 2))
              : const Border()),
      child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: _size.width / 15, vertical: _size.height / 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              type == "deposit" ? Text(dateFormat.format(deposit!.date!)) : type == "balance" ? Text(dateFormat.format(balance!.date!)) : Text(dateFormat.format(request!.date!)),
              SizedBox(height: _size.height / 50),
              type == "deposit" ?
              deposit!.status == "plus"
                  ? Row(
                      children: [
                        const Expanded(child: Text("Deposit Return")),
                        Text(
                          "+ ${currencyFormatter.format(deposit!.amount).toString()}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  : Row(
                      children: [
                        const Expanded(child: Text("Deposit Request")),
                        Text(
                          "- ${currencyFormatter.format(deposit!.amount).toString()}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ) : 
              type == "balance" ?
              balance!.status == "plus"
                  ? Row(
                      children: [
                        const Expanded(child: Text("Balance Return")),
                        Text(
                          "+ ${currencyFormatter.format(balance!.amount).toString()}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  : Row(
                      children: [
                        const Expanded(child: Text("Balance Request")),
                        Text(
                          "- ${currencyFormatter.format(balance!.amount).toString()}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ) : type == "admin"? Row(
                      children: [
                        Expanded(child: Text("Request: ${request!.id}")),
                        Text(
                          currencyFormatter.format(request!.amount).toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ) : Row(
                      children: [
                        Expanded(child: Text("Status: ${request!.status}")),
                        Text(
                          currencyFormatter.format(request!.amount).toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
              SizedBox(height: _size.height / 50),
              type == "deposit" ?
              deposit!.status == "plus"
                  ? Text("Transaction Id: ${deposit!.detail_id!.id}")
                  : Text("Request Id: ${deposit!.detail_id!.id}"): 
              type == "balance" ?
              balance!.status == "plus"
                  ? Text("Transaction Id: ${balance!.detail_id!.id}")
                  : Text("Request Id: ${balance!.detail_id!.id}") 
                  : type == "admin" ? Text("Status: ${request!.status}") : Text(request!.account_name.toString())
            ],
          )),
    );
  }
}
