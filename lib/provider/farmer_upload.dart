import 'package:app/farmer_direc/orders/viewmodel/orderViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/farmer_direc/orders/model/order_model.dart';

class UploadExampleOrdersScreen extends StatelessWidget {
  // List of example orders to upload
  final List<OrderModel> exampleOrders = [
    OrderModel(
      orderID: "orderModel1",
      itemID: "item1",
      itemPrice: 1500.75,
      itemCount: 1,
      status: OrderStatus.completed,
      rating: 5,
    ),
    OrderModel(
      orderID: "orderModel2",
      itemID: "item2",
      itemPrice: 800.50,
      itemCount: 1,
      status: OrderStatus.inTransit,
      rating: 0,
    ),
    OrderModel(
      orderID: "orderModel3",
      itemID: "item3",
      itemPrice: 1200.00,
      itemCount: 1,
      status: OrderStatus.confirmed,
      rating: 0,
    ),
    OrderModel(
      orderID: "orderModel4",
      itemID: "item4",
      itemPrice: 250.25,
      itemCount: 1,
      status: OrderStatus.completed,
      rating: 4,
    ),
    OrderModel(
      orderID: "orderModel5",
      itemID: "item5",
      itemPrice: 500.50,
      itemCount: 1,
      status: OrderStatus.canceled,
      rating: 0,
    ),
    OrderModel(
      orderID: "orderModel6",
      itemID: "item6",
      itemPrice: 3000.00,
      itemCount: 1,
      status: OrderStatus.completed,
      rating: 3,
    ),
    OrderModel(
      orderID: "orderModel7",
      itemID: "item7",
      itemPrice: 600.40,
      itemCount: 1,
      status: OrderStatus.inTransit,
      rating: 0,
    ),
    OrderModel(
      orderID: "orderModel8",
      itemID: "item8",
      itemPrice: 900.99,
      itemCount: 1,
      status: OrderStatus.completed,
      rating: 5,
    ),
    OrderModel(
      orderID: "orderModel9",
      itemID: "item9",
      itemPrice: 450.80,
      itemCount: 1,
      status: OrderStatus.confirmed,
      rating: 0,
    ),
    OrderModel(
      orderID: "orderModel10",
      itemID: "item10",
      itemPrice: 200.50,
      itemCount: 1,
      status: OrderStatus.canceled,
      rating: 0,
    ),
    OrderModel(
      orderID: "orderModel11",
      itemID: "item11",
      itemPrice: 150.25,
      itemCount: 1,
      status: OrderStatus.completed,
      rating: 4,
    ),
    OrderModel(
      orderID: "orderModel12",
      itemID: "item12",
      itemPrice: 1800.99,
      itemCount: 1,
      status: OrderStatus.inTransit,
      rating: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Example Orders'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final orderProvider = Provider.of<OrderProvider>(context, listen: false);
            final farmerId = 'farmerA123'; // Replace with actual farmer ID
            
            try {
              for (var order in exampleOrders) {
                await orderProvider.addOrder(farmerId, order);
              }
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All example orders uploaded successfully')));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to upload orders: $e')));
            }
          },
          child: Text('Upload All Orders'),
        ),
      ),
    );
  }
}
