import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Container(
          // height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50)
          ),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: [
                  Expanded(
                    child: Image.network(
                      // height: 100,
                      "https://picsum.photos/id/30/200",
                      fit: BoxFit.fill,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text('Raket',style: TextStyle( fontSize: 18),),
                  )  ,

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text("Rp. 150.000/hour",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: const [
                        Text("Detail",)
                      ],
                    ),
                  )

                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
