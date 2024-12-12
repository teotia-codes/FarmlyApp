import 'package:flutter/material.dart';

class MonthlyDeliveriesScreen extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Deliveries'),
      ),
      body: ListView.builder(
        itemCount: deliveries.length,
        itemBuilder: (context, index) {
          var delivery = deliveries[index];

          return Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: Icon(Icons.delivery_dining, size: 50, color: Colors.orange),
              title: Text(
                'Buyer: ${delivery['buyer']}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
    );
  }
}
