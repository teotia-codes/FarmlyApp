import 'package:flutter/material.dart';
import '../data/product.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class FarmerInfo extends StatefulWidget {
  const FarmerInfo({super.key, required this.product});
  final Product product;
  @override
  State<FarmerInfo> createState() => _FarmerInfoState();
}

class _FarmerInfoState extends State<FarmerInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Farmer Details"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.bookmark),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16), // Padding around the list view
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
            child: CircleAvatar(
              radius: 62,
              backgroundColor: Colors.green[200],
              child: const Icon(
                size: 60,
                Icons.person,
              ),
            ),
          ),
          const Center(
            child: Text(
          "ID",
            style: TextStyle(
              fontWeight:FontWeight.w700,

    )
            ),
          ),
          // NAME
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
          const Row(
            children:[
              Text("NAME: ",
              style:TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
              Text(
                "Mak Mach",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                )
              ),
            ],
          ),
              const SizedBox(height: 10,),
              const Row(
                children:[
                  Text("Address: ",
                      style:TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                      "Chengalpattu",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      )
                  ),
                ],
              ),
              const SizedBox(height:10),
              const Row(
                children:[
                  Text("CIBIL Score: ",
                      style:TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                      "120",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      )
                  ),
                ],
              ),
              const SizedBox(height:20),
              const Text(
                "Products",
                style:TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                )
              ),
              const SizedBox(height:15),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return ProductCard(product: products[index]);
                },
              ),


            ],
          ),

        ],
      ),
    );
  }
}