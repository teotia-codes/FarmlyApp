import 'package:flutter/material.dart';

class CollectiveSellingScreen extends StatefulWidget {
  @override
  _CollectiveSellingScreenState createState() =>
      _CollectiveSellingScreenState();
}

class _CollectiveSellingScreenState extends State<CollectiveSellingScreen> {
  final List<Map<String, dynamic>> products = [
    {'name': 'Potatoes', 'quantity': 50, 'price': 20},
    {'name': 'Tomatoes', 'quantity': 100, 'price': 15},
    {'name': 'Wheat', 'quantity': 200, 'price': 30},
  ];

  void _addProduct() {
    showDialog(
      context: context,
      builder: (context) {
        final nameController = TextEditingController();
        final quantityController = TextEditingController();
        final priceController = TextEditingController();

        return AlertDialog(
          title: const Text('Add New Product'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Product Name'),
                ),
                TextField(
                  controller: quantityController,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price (₹)'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final name = nameController.text.trim();
                final quantity =
                    int.tryParse(quantityController.text.trim()) ?? 0;
                final price = int.tryParse(priceController.text.trim()) ?? 0;

                if (name.isNotEmpty && quantity > 0 && price > 0) {
                  setState(() {
                    products.add({
                      'name': name,
                      'quantity': quantity,
                      'price': price,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collective Selling'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: const Icon(Icons.shopping_cart, size: 50),
              title: Text(
                products[index]['name'],
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(
                  'Quantity: ${products[index]['quantity']} | Price: ₹${products[index]['price']}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProduct,
        child: const Icon(Icons.add),
      ),
    );
  }
}
