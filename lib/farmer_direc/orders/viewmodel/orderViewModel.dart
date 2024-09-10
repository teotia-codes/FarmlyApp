

import 'package:app/farmer_direc/dashboard/model/farmer_model.dart';
import 'package:app/farmer_direc/orders/model/order_model.dart';

class OrderViewModel {
  final FarmerModel farmerModel;

  OrderViewModel({required this.farmerModel});

  int returnCompletedOrders() {
    List<OrderModel> ordersList = farmerModel.orders;
    int count = 0;
    for (var orderModel in ordersList) {
      for (var entry in orderModel.orders.entries) {
        if (entry.value.status == OrderStatus.completed) {
          count++;
        }
      }
    }
    return count;
  }

  int returnInTransitOrders() {
    List<OrderModel> ordersList = farmerModel.orders;
    int count = 0;
    for (var orderModel in ordersList) {
      for (var entry in orderModel.orders.entries) {
        if (entry.value.status == OrderStatus.inTransit) {
          count++;
        }
      }
    }
    return count;
  }

  int returnCanceledOrders() {
    List<OrderModel> ordersList = farmerModel.orders;
    int count = 0;
    for (var orderModel in ordersList) {
      for (var entry in orderModel.orders.entries) {
        if (entry.value.status == OrderStatus.canceled) {
          count++;
        }
      }
    }
    return count;
  }
}

OrderViewModel exampleOrderViewModel =
    OrderViewModel(farmerModel: exampleFarmer);
