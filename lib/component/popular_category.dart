import 'package:flutter/material.dart';

class PopularCategory extends StatefulWidget {
  const PopularCategory({Key? key}) : super(key: key);

  @override
  State<PopularCategory> createState() => _PopularCategoryState();
}

class _PopularCategoryState extends State<PopularCategory> {

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: _size.height/100),

      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: _size.width / 30, vertical: _size.height / 75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Popular Categories",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20)),
                Text(
                  "see all",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.3),
                          borderRadius: BorderRadius.circular(10)),
                      child: const ImageIcon(
                        AssetImage("assets/icons/shoe.png")
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Text("Shoes")),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(width: 0.3),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Text("Hat")),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(width: 0.3),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Text("Shirt")),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(width: 0.3),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Text("Racket")),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
