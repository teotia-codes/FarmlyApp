import 'package:app/retailer_direc/models/order.dart';
import 'package:app/retailer_direc/models/ROrderViewModel.dart';
import 'package:app/retailer_direc/widgets/order_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Make sure to include provider

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ROrderProvider>(context);

    final tabs = OrderStatus.values.map((e) => e.name).toList();

    // Fetch orders when the widget is first built
    Future<void> fetchOrders() async {
      // Assuming you have access to the retailer ID
      final retailerId = 'your_retailer_id'; // Replace with the actual retailer ID
      await provider.fetchOrders(retailerId);
    }

    // Call fetchOrders() in initState() or use FutureBuilder for async fetching
    fetchOrders();

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("My Orders"),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            tabs: List.generate(tabs.length, (index) {
              return Tab(text: tabs[index]);
            }),
          ),
        ),
        body: TabBarView(
          children: List.generate(tabs.length, (index) {
            final fileOrders = provider.orders
                .where((order) => order.status == OrderStatus.values[index])
                .toList();
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final order = fileOrders[index];
                return OrderItemWidget(order: order);
              },
              separatorBuilder: (context, index) => const SizedBox(),
              itemCount: fileOrders.length,
            );
          }),
        ),
      ),
    );
  }
}
