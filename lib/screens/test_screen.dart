import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sporent/model/product.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference products = firestore.collection('product');
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            decoration: BoxDecoration(border: Border.all()),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('product')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    List<QueryDocumentSnapshot<
                        Map<String, dynamic>>>? listDocs = snapshot.data?.docs;
                    inspect(listDocs);
                    List<Product> listProduct = [];
                    for (int i = 0; i < listDocs!.length; i++) {
                      Map<String, dynamic> data = listDocs[i].data();
                      Product p = Product(
                        listDocs[i].id,
                          data['name'], data['price'], data['location'],
                          data['img']);
                      listProduct.add(p);
                    }

                    return
                      SingleChildScrollView(
                        controller: ScrollController(),
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                          shrinkWrap: true,
  itemCount: listProduct.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context ,index){
                            return Center(
                              child: Text(listProduct[index].name!),
                            );
                          },

                        ),
                      );
                    //   ListView(
                    //   shrinkWrap: true,
                    //     scrollDirection: Axis.vertical,
                    //     children: snapshot.data!.docs.map((e) {
                    //   Map<String, dynamic> data =
                    //       e.data();
                    //   log("====  data$data");
                    //   return ListTile(title: const Text("Name"),subtitle: Text(data['name']?? "No Name"));
                    // }).toList());

                    // GridView.builder(
                    //   itemCount: listDocs?.length,
                    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //         crossAxisCount: 2), itemBuilder: (contex, index) {
                    //     var item = listDocs![index];
                    //     item.data().forEach((key, value) {
                    //       log(value);
                    //     });
                    //     inspect(item);
                    //
                    //   return Center(
                    //     child: Text("name: ")
                    //   );
                    // });
                  }
                }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 300,
              child: Column(
                verticalDirection: VerticalDirection.up,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        products.add({
                          'name': nameController.text,
                          'price': int.tryParse(priceController.text),
                          'location': int.tryParse(locationController.text)
                        });

                        nameController.text = "";
                        priceController.text = "";
                        locationController.text = "";
                      },
                      child: const Text("Add")),
                  TextField(
                    controller: locationController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'location'),
                  ),
                  TextField(
                    controller: priceController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'price'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Name'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
