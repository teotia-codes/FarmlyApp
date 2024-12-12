import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void uploadDummyOrders() async {
  final orders = [
    {
      'orderID': 'order1',
      'item': {
        'itemID': 'item1',
        'itemName': 'Wheat',
        'itemCount': 10,
        'itemPrice': 15.5,
      },
      'amount': 155.0,
      'farmerID': 'farmerA123',
      'retailerID': 'retailerA123',
      'status': 'confirmed',
      'rating': 0,
    },
    {
      'orderID': 'order2',
      'item': {
        'itemID': 'item2',
        'itemName': 'Rice',
        'itemCount': 20,
        'itemPrice': 12.0,
      },
      'amount': 240.0,
      'farmerID': 'farmerA123',
      'retailerID': 'retailerA123',
      'status': 'inTransit',
      'rating': 0,
    },
    {
      'orderID': 'order3',
      'item': {
        'itemID': 'item3',
        'itemName': 'Barley',
        'itemCount': 15,
        'itemPrice': 18.0,
      },
      'amount': 270.0,
      'farmerID': 'farmerA123',
      'retailerID': 'retailerA123',
      'status': 'completed',
      'rating': 4,
    },
  ];

  for (var order in orders) {
    await FirebaseFirestore.instance.collection('orders').doc(order['orderID'].toString()).set(order);
  }

  print("Dummy orders uploaded successfully!");
}



class OrdersUpload extends StatelessWidget {
  const OrdersUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: () async
        {
          uploadDummyOrders();
        }, child: Text("Upload Orders")),
      ),
    );
  }
}