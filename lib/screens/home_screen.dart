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
          // GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount)
        ],
      ),
    ));
  }
}
