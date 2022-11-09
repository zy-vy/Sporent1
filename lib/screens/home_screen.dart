import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: Colors.grey),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      // spreadRadius: 3,
                      blurRadius: 4,
                      offset: const Offset(4, 5),
                    )
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Search", style: TextStyle(color: Colors.grey)),
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 10, 20, 10),
                    child: Text("Popular Categories",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 10, 20, 0),
                    child: Text(
                      "see all",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                ],
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
                              color: Colors.grey,
                              border: Border.all(width: 0.3),
                              borderRadius: BorderRadius.circular(10)),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10, 20, 10),
                child: Text("Today's Recommendation",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10, 20, 0),
                child: Text(
                  "see all",
                  style: TextStyle(color: Colors.grey),
                ),
              )
            ],
          ),
          GridView.builder(
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (ctx, i) {
                return Card(
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
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 5,
                mainAxisExtent: 264,
              ))
        ],
      ),
    ));
  }
}
