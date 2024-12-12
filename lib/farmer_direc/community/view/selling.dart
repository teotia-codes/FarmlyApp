import 'package:flutter/material.dart';

class CollectiveSellingScreen extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {'name': 'Potatoes', 'quantity': 50, 'price': 20},
    {'name': 'Tomatoes', 'quantity': 100, 'price': 15},
    {'name': 'Wheat', 'quantity': 200, 'price': 30},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collective Selling'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(products[index]['name']),
              subtitle: Text('Quantity: ${products[index]['quantity']} | Price: ₹${products[index]['price']}'),
              leading: Icon(Icons.shopping_cart),
            ),
          );
        },
      ),
    );
  }
}
