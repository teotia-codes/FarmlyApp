import 'package:app/farmer_direc/dashboard/model/farmer_model.dart';
import 'package:app/farmer_direc/inventory/model/farmer_inventory_model.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
// Import your FarmerModel
import '../widgets/product_card.dart';

class FarmerInfo extends StatefulWidget {
  const FarmerInfo({super.key, required this.farmer});
  final FarmerModel farmer; // Accept FarmerModel instance

  @override
  State<FarmerInfo> createState() => _FarmerInfoState();
}

class _FarmerInfoState extends State<FarmerInfo> {
  @override
  Widget build(BuildContext context) {
    // Extract product list from the farmer's inventory
    List<Product> products = exampleInventoryItems
        .where((item) => item.farmerID == widget.farmer.id) // Filter by farmer ID
        .map((item) => Product(
          name: item.name,
          farmer: widget.farmer.name,
          description: 'Description for ${item.name}', // You might want to improve the description
          image: item.imageUrl,
          price: double.tryParse(item.price) ?? 0.0,
          unit: 'kg',
          rating: 4.0, // Provide a default or calculated rating
        ))
        .toList();

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
          Center(
            child: Text(
              widget.farmer.id, // Display farmer ID
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          // NAME
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "NAME: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.farmer.name, // Display farmer name
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "Address: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.farmer.add, // Display farmer address
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "CIBIL Score: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${widget.farmer.credit.cibilScore}", // Display CIBIL score from credit model
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Products",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 15),
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
