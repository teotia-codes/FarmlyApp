import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/retailer_direc/models/order.dart';
import 'package:app/retailer_direc/pages/ratings_retail.dart';
import 'package:app/utils/appcolors.dart';
import 'package:app/utils/texttheme.dart';

class RetailerOrderView extends StatefulWidget {
  final String retailerId;
  final String? initialSortOption;

  const RetailerOrderView({
    super.key,
    required this.retailerId,
    this.initialSortOption,
  });

  @override
  State<RetailerOrderView> createState() => _RetailerOrderViewState();
}

class _RetailerOrderViewState extends State<RetailerOrderView> {
  List<ROrderModel> _retailerOrders = [];
  late String _selectedSortOption;
  final List<String> _sortOptions = ['All', 'inTransit', 'completed', 'confirmed', 'canceled'];

  @override
  void initState() {
    super.initState();
    _selectedSortOption = widget.initialSortOption ?? 'All';
    _fetchRetailerOrders();
  }

  Future<void> _fetchRetailerOrders() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('retailerID', isEqualTo: 'retailerA123')
          .get();

      setState(() {
        _retailerOrders = querySnapshot.docs.map((doc) {
          return ROrderModel.fromFirestore(doc.data() as Map<String, dynamic>);
        }).toList();
      });
    } catch (e) {
      print('Error fetching retailer orders: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ROrderModel> filteredOrders = _retailerOrders.where((order) {
      if (_selectedSortOption == 'All') return true;
      return _selectedSortOption == order.status.toString().split('.').last;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.kBackground,
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: TextPref.opensans.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.kBackground,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.filter_list, color: Colors.white),
            onSelected: (String value) {
              setState(() {
                _selectedSortOption = value;
              });
            },
            itemBuilder: (BuildContext context) {
              return _sortOptions.map((String option) {
                return PopupMenuItem<String>(
                  value: option,
                  child: Text(
                    option == 'All' ? 'All Orders' : 
                    option.substring(0, 1).toUpperCase() + option.substring(1),
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: _retailerOrders.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Showing ${_selectedSortOption == "All" ? "All" : _selectedSortOption} Orders',
                    style: TextPref.opensans.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(16),
                    itemCount: filteredOrders.length,
                    separatorBuilder: (context, index) => SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];

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

                      // Calculate total amount
                      double totalAmount = order.itemPrice * order.itemCount;

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GiveRatingsScreen(
                                orderId: order.orderID,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.PaleYellow,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            title: Text(
                              'Order ID: ${order.orderID}',
                              style: TextPref.opensans.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Item: ${order.itemName}',
                                  style: TextPref.opensans.copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                Text(
                                  'Amount: ₹${totalAmount.toStringAsFixed(2)}',
                                  style: TextPref.opensans.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.green[700],
                                  ),
                                ),
                                Text(
                                  'Status: ${order.status.toString().split('.').last}',
                                  style: TextPref.opensans.copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    color: statusColor,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Icon(
                              Icons.shopping_cart,
                              color: statusColor,
                              size: 30,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}