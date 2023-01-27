import 'package:flutter/material.dart';

import '../screens/result_search_product.dart';

class SearchBarProduct extends StatefulWidget {
  const SearchBarProduct(this.isLogin, {super.key});

  final bool isLogin;

  @override
  State<SearchBarProduct> createState() => _SearchBarProductState();
}

class _SearchBarProductState extends State<SearchBarProduct> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: _size.height / 50),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            suffixIcon: const Icon(Icons.search_outlined),
            hintText: "Search",
            contentPadding: const EdgeInsets.symmetric(horizontal: 15)),
        onFieldSubmitted: (value) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ResultSearchProduct(controller.text, widget.isLogin)));
        },
      ),
    );
  }
}