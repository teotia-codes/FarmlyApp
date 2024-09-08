import 'package:app/farmer_direc/orders/model/order_model.dart';
import 'package:app/utils/appcolors.dart';
import 'package:app/utils/texttheme.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/material.dart';

class OrderView extends StatefulWidget {
  final String? initialSortOption; // Nullable to allow default value

  const OrderView({super.key, this.initialSortOption});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  late String _selectedSortOption;

  @override
  void initState() {
    super.initState();
    // Set default value if none is provided
    _selectedSortOption = widget.initialSortOption ?? 'All';
  }

  @override
  Widget build(BuildContext context) {
    List<MapEntry<String, OrderDetails>> filteredOrders = exampleOrderModels
        .expand((orderModel) => orderModel.orders.entries)
        .where((entry) {
      if (_selectedSortOption == 'All') return true;
      return _selectedSortOption ==
          entry.value.status.toString().split('.').last;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.kBackground,
      appBar: AppBar(
        title: Text(
          'Order List',
          style: TextPref.opensans.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: AppColors.kBackground,
        elevation: 1,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.filter_list_rounded),
            onSelected: (String result) {
              setState(() {
                _selectedSortOption = result;
              });
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'All',
                child: Text(
                  'All',
                  style: TextPref.opensans.copyWith(fontSize: 16),
                ),
              ),
              PopupMenuItem<String>(
                value: 'inTransit',
                child: Text(
                  'In Transit',
                  style: TextPref.opensans.copyWith(fontSize: 16),
                ),
              ),
              PopupMenuItem<String>(
                value: 'completed',
                child: Text(
                  'Completed',
                  style: TextPref.opensans.copyWith(fontSize: 16),
                ),
              ),
              PopupMenuItem<String>(
                value: 'confirmed',
                child: Text(
                  'Confirmed',
                  style: TextPref.opensans.copyWith(fontSize: 16),
                ),
              ),
              PopupMenuItem<String>(
                value: 'canceled',
                child: Text(
                  'Canceled',
                  style: TextPref.opensans.copyWith(fontSize: 16),
                ),
              ),
            ],
          ),
          SizedBox(width: 16),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: filteredOrders.length,
        separatorBuilder: (context, index) => SizedBox(height: 16),
        itemBuilder: (context, index) {
          final entry = filteredOrders[index];
          final orderId = entry.key;
          final orderDetails = entry.value;

          Color statusColor;
          switch (orderDetails.status) {
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
              'Order ID: $orderId',
              style: TextPref.opensans.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              'Amount: \₹${orderDetails.amount.toStringAsFixed(2)}\nStatus: ${orderDetails.status.toString().split('.').last}',
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
