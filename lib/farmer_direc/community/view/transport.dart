import 'package:flutter/material.dart';

class TransportLogisticsScreen extends StatefulWidget {
  @override
  _TransportLogisticsScreenState createState() =>
      _TransportLogisticsScreenState();
}

class _TransportLogisticsScreenState extends State<TransportLogisticsScreen> {
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

  void _addTransportOption() {
    showDialog(
      context: context,
      builder: (context) {
        final vehicleController = TextEditingController();
        final availabilityController = TextEditingController();
        final costPerTripController = TextEditingController();

        return AlertDialog(
          title: const Text('Add New Transport Option'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: vehicleController,
                  decoration: const InputDecoration(labelText: 'Vehicle Name'),
                ),
                TextField(
                  controller: availabilityController,
                  decoration: const InputDecoration(labelText: 'Availability'),
                ),
                TextField(
                  controller: costPerTripController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Cost per Trip'),
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
                final vehicle = vehicleController.text.trim();
                final availability = availabilityController.text.trim();
                final costPerTrip =
                    int.tryParse(costPerTripController.text.trim());

                if (vehicle.isNotEmpty &&
                    availability.isNotEmpty &&
                    costPerTrip != null) {
                  setState(() {
                    transportOptions.add({
                      'vehicle': vehicle,
                      'availability': availability,
                      'cost_per_trip': costPerTrip,
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
        title: const Text('Transport & Logistics'),
      ),
      body: ListView.builder(
        itemCount: transportOptions.length,
        itemBuilder: (context, index) {
          var option = transportOptions[index];

          return Card(
            margin: const EdgeInsets.all(10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: const Icon(Icons.local_shipping,
                  size: 50, color: Colors.blue),
              title: Text(
                option['vehicle'],
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _addTransportOption,
        child: const Icon(Icons.add),
      ),
    );
  }
}
