// Example instances of OrderModel and OrderDetails

import 'package:app/farmer_direc/orders/model/order_model.dart';

OrderModel exampleOrder1 = OrderModel(
  orders: {
    'order1': OrderDetails(
      amount: 1500.75,
      status: OrderStatus.completed,
      rating: 5, // Only completed orders have ratings
    ),
    'order2': OrderDetails(
      amount: 800.50,
      status: OrderStatus.inTransit,
      rating: 0, // No rating for inTransit orders
    ),
    'order3': OrderDetails(
      amount: 1200.00,
      status: OrderStatus.confirmed,
      rating: 0, // No rating for confirmed orders
    ),
    'order4': OrderDetails(
      amount: 250.25,
      status: OrderStatus.completed,
      rating: 4, // Completed order with a rating
    ),
    'order5': OrderDetails(
      amount: 500.50,
      status: OrderStatus.canceled,
      rating: 0, // No rating for canceled orders
    ),
  },
);

OrderModel exampleOrder2 = OrderModel(
  orders: {
    'order6': OrderDetails(
      amount: 3000.00,
      status: OrderStatus.completed,
      rating: 3, // Completed order with a rating
    ),
    'order7': OrderDetails(
      amount: 600.40,
      status: OrderStatus.inTransit,
      rating: 0, // No rating for inTransit orders
    ),
    'order8': OrderDetails(
      amount: 900.99,
      status: OrderStatus.completed,
      rating: 5, // Completed order with a rating
    ),
    'order9': OrderDetails(
      amount: 450.80,
      status: OrderStatus.confirmed,
      rating: 0, // No rating for confirmed orders
    ),
  },
);

OrderModel exampleOrder3 = OrderModel(
  orders: {
    'order10': OrderDetails(
      amount: 200.50,
      status: OrderStatus.canceled,
      rating: 0, // No rating for canceled orders
    ),
    'order11': OrderDetails(
      amount: 150.25,
      status: OrderStatus.completed,
      rating: 4, // Completed order with a rating
    ),
    'order12': OrderDetails(
      amount: 1800.99,
      status: OrderStatus.inTransit,
      rating: 0, // No rating for inTransit orders
    ),
  },
);

// List of example orders
List<OrderModel> exampleOrders = [exampleOrder1, exampleOrder2, exampleOrder3];
