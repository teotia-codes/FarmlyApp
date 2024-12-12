import 'package:flutter/material.dart';

class TransportLogisticsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> transportOptions = [
    {
      'vehicle': 'Tractor',
      'availability': 'Available',
      'cost_per_trip': 500,
    },
    {
      'vehicle': 'Truck',
      'availability': 'Not Available',
      'cost_per_trip': 1000,
    },
    {
      'vehicle': 'Rickshaw',
      'availability': 'Available',
      'cost_per_trip': 300,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transport & Logistics'),
      ),
      body: ListView.builder(
        itemCount: transportOptions.length,
        itemBuilder: (context, index) {
          var option = transportOptions[index];

          return Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: Icon(Icons.local_shipping, size: 50, color: Colors.blue),
              title: Text(
                option['vehicle'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Availability: ${option['availability']}'),
                  Text('Cost per Trip: ₹${option['cost_per_trip']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
