import 'package:app/retailer_direc/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';


class OrderItemWidget extends StatelessWidget {
  final ROrderModel order;

  const OrderItemWidget({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalPrice = order.itemPrice * order.itemCount; // Calculate total price
    
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Order ID: ${order.orderID}",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '1 item', // Since `OrderModel` handles one item at a time
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(width: 5),
                Text(
                  '\₹${totalPrice.toStringAsFixed(2)}',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Status: ${order.status.toString().split('.').last}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: _getStatusColor(order.status),
              ),
            ),
            if (order.rating > 0) ...[
              const SizedBox(height: 10),
              Text(
                'Rating: ${order.rating}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.black54,
                ),
              ),
            ],
            const SizedBox(height: 10),
            if (order.itemCount > 1)
              TextButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    isScrollControlled: true,
                    builder: (context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: ListView(
                          padding: const EdgeInsets.all(14),
                          children: [
                            Text(
                              'Order ID: ${order.orderID}',
                              style: theme.textTheme.headlineLarge,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Total Price: \₹${totalPrice.toStringAsFixed(2)}',
                              style: theme.textTheme.labelMedium,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Status: ${order.status.toString().split('.').last}',
                              style: theme.textTheme.labelMedium,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Rating: ${order.rating}',
                              style: theme.textTheme.labelMedium,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                label: const Text("View Details"),
                icon: const Icon(IconlyBold.arrowRight),
              ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.inTransit:
        return Colors.blue;
      case OrderStatus.completed:
        return Colors.green;
      case OrderStatus.confirmed:
        return Colors.orange;
      case OrderStatus.canceled:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
