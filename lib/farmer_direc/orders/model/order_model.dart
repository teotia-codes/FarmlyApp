class OrderModel {
  Map<String, OrderDetails> orders;

  OrderModel({
    required this.orders,
  });
}

class OrderDetails {
  double amount;
  OrderStatus status;
  int rating = 0;

  OrderDetails({
    required this.amount,
    required this.status,
  });
}

enum OrderStatus {
  inTransit,
  completed,
  confirmed,
  canceled,
}

List<OrderModel> exampleOrderModels = [
  OrderModel(
    orders: {
      'order1': OrderDetails(amount: 150.0, status: OrderStatus.confirmed),
      'order2': OrderDetails(amount: 200.0, status: OrderStatus.inTransit),
      'order3': OrderDetails(amount: 250.0, status: OrderStatus.completed),
    },
  ),
  OrderModel(
    orders: {
      'order4': OrderDetails(amount: 100.0, status: OrderStatus.canceled),
      'order5': OrderDetails(amount: 300.0, status: OrderStatus.confirmed),
      'order6': OrderDetails(amount: 175.0, status: OrderStatus.inTransit),
    },
  ),
  OrderModel(
    orders: {
      'order7': OrderDetails(amount: 220.0, status: OrderStatus.completed),
      'order8': OrderDetails(amount: 130.0, status: OrderStatus.confirmed),
      'order9': OrderDetails(amount: 190.0, status: OrderStatus.canceled),
    },
  ),
];
