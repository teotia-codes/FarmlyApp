import 'package:flutter/material.dart';

class MonthlyDeliveriesScreen extends StatefulWidget {
  @override
  _MonthlyDeliveriesScreenState createState() =>
      _MonthlyDeliveriesScreenState();
}

class _MonthlyDeliveriesScreenState extends State<MonthlyDeliveriesScreen> {
  final List<Map<String, dynamic>> deliveries = [
    {
      'buyer': 'GreenMart',
      'products': ['Potatoes', 'Tomatoes'],
      'quantity': '500 kg',
      'deliveryDate': '2024-06-30',
    },
    {
      'buyer': 'Local Market',
      'products': ['Wheat', 'Onions'],
      'quantity': '1000 kg',
      'deliveryDate': '2024-07-15',
    },
    {
      'buyer': 'SuperFresh',
      'products': ['Carrots', 'Cauliflower'],
      'quantity': '750 kg',
      'deliveryDate': '2024-08-01',
    },
  ];

  void _addDelivery() {
    showDialog(
      context: context,
      builder: (context) {
        final buyerController = TextEditingController();
        final productsController = TextEditingController();
        final quantityController = TextEditingController();
        final deliveryDateController = TextEditingController();

        return AlertDialog(
          title: const Text('Add New Delivery'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: buyerController,
                  decoration: const InputDecoration(labelText: 'Buyer'),
                ),
                TextField(
                  controller: productsController,
                  decoration: const InputDecoration(
                      labelText: 'Products (comma-separated)'),
                ),
                TextField(
                  controller: quantityController,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                ),
                TextField(
                  controller: deliveryDateController,
                  decoration: const InputDecoration(
                      labelText: 'Delivery Date (YYYY-MM-DD)'),
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
                final buyer = buyerController.text.trim();
                final products = productsController.text
                    .split(',')
                    .map((e) => e.trim())
                    .toList();
                final quantity = quantityController.text.trim();
                final deliveryDate = deliveryDateController.text.trim();

                if (buyer.isNotEmpty &&
                    products.isNotEmpty &&
                    quantity.isNotEmpty &&
                    deliveryDate.isNotEmpty) {
                  setState(() {
                    deliveries.add({
                      'buyer': buyer,
                      'products': products,
                      'quantity': quantity,
                      'deliveryDate': deliveryDate,
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
        title: const Text('Monthly Deliveries'),
      ),
      body: ListView.builder(
        itemCount: deliveries.length,
        itemBuilder: (context, index) {
          var delivery = deliveries[index];

          return Card(
            margin: const EdgeInsets.all(10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: const Icon(Icons.delivery_dining,
                  size: 50, color: Colors.orange),
              title: Text(
                'Buyer: ${delivery['buyer']}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Products: ${delivery['products'].join(', ')}'),
                  Text('Quantity: ${delivery['quantity']}'),
                  Text('Delivery Date: ${delivery['deliveryDate']}'),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addDelivery,
        child: const Icon(Icons.add),
      ),
    );
  }
}
