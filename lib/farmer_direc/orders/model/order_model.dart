class OrderModel {
  Map<String, OrderDetails> orders;

  OrderModel({required this.orders});

  Map<String, dynamic> toFirestore() {
    return {
      'orders': orders.map((key, value) => MapEntry(key, value.toFirestore())),
    };
  }
}

class OrderDetails {
  double amount;
  OrderStatus status;
  int rating;

  OrderDetails({required this.amount, required this.status, this.rating = 0});

  Map<String, dynamic> toFirestore() {
    return {
      'amount': amount,
      'status': status.toString().split('.').last,  // Store the status as a string
      'rating': rating,
    };
  }
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
