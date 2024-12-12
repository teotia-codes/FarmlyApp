import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/farmer_direc/orders/model/order_model.dart';
import 'package:app/utils/appcolors.dart';
import 'package:app/utils/texttheme.dart';

class OrderView extends StatefulWidget {
  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  List<OrderModel> _farmerOrders = [];

  @override
  void initState() {
    super.initState();
    _fetchFarmerOrders();
  }

  Future<void> _fetchFarmerOrders() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('farmerID', isEqualTo: 'farmerA123')
          .get();

      setState(() {
        _farmerOrders = querySnapshot.docs.map((doc) {
          return OrderModel.fromFirestore(doc.data() as Map<String, dynamic>);
        }).toList();
      });
    } catch (e) {
      print('Error fetching farmer orders: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      appBar: AppBar(
        title: Text(
          'Farmer Orders',
          style: TextPref.opensans.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: AppColors.kBackground,
        elevation: 1,
      ),
      body: _farmerOrders.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              padding: EdgeInsets.all(16),
              itemCount: _farmerOrders.length,
              separatorBuilder: (context, index) => SizedBox(height: 16),
              itemBuilder: (context, index) {
                final order = _farmerOrders[index];

                Color statusColor;
                switch (order.status) {
                  case OrderStatus.inTransit:
                    statusColor = Colors.blue;
                    break;
                  case OrderStatus.completed:
                    statusColor = Colors.green;
                    break;
                  case OrderStatus.confirmed:
                    statusColor = Colors.orange;
                    break;
                  case OrderStatus.canceled:
                    statusColor = Colors.red;
                    break;
                  default:
                    statusColor = Colors.grey;
                }

                return ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  tileColor: AppColors.PaleYellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: AppColors.kBackground, width: 1),
                  ),
                  title: Text(
                    'Order ID: ${order.orderID}',
                    style: TextPref.opensans.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    'Amount: \₹${(order.itemPrice * order.itemCount).toStringAsFixed(2)}\nStatus: ${order.status.toString().split('.').last}',
                    style: TextPref.opensans.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  trailing: Icon(
                    Icons.shopping_cart,
                    color: statusColor,
                  ),
                );
              },
            ),
    );
  }
}