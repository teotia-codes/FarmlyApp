import 'package:app/farmer_direc/orders/model/order_model.dart';

// Example instances of OrderModel

OrderModel exampleOrder1 = OrderModel(
  orderID: "orderModel1",
  itemID: "item1",
  itemPrice: 1500.75,
  itemCount: 1,
  status: OrderStatus.completed,
  rating: 5,
);

OrderModel exampleOrder2 = OrderModel(
  orderID: "orderModel2",
  itemID: "item2",
  itemPrice: 800.50,
  itemCount: 1,
  status: OrderStatus.inTransit,
  rating: 0,
);

OrderModel exampleOrder3 = OrderModel(
  orderID: "orderModel3",
  itemID: "item3",
  itemPrice: 1200.00,
  itemCount: 1,
  status: OrderStatus.confirmed,
  rating: 0,
);

OrderModel exampleOrder4 = OrderModel(
  orderID: "orderModel4",
  itemID: "item4",
  itemPrice: 250.25,
  itemCount: 1,
  status: OrderStatus.completed,
  rating: 4,
);

OrderModel exampleOrder5 = OrderModel(
  orderID: "orderModel5",
  itemID: "item5",
  itemPrice: 500.50,
  itemCount: 1,
  status: OrderStatus.canceled,
  rating: 0,
);

OrderModel exampleOrder6 = OrderModel(
  orderID: "orderModel6",
  itemID: "item6",
  itemPrice: 3000.00,
  itemCount: 1,
  status: OrderStatus.completed,
  rating: 3,
);

OrderModel exampleOrder7 = OrderModel(
  orderID: "orderModel7",
  itemID: "item7",
  itemPrice: 600.40,
  itemCount: 1,
  status: OrderStatus.inTransit,
  rating: 0,
);

OrderModel exampleOrder8 = OrderModel(
  orderID: "orderModel8",
  itemID: "item8",
  itemPrice: 900.99,
  itemCount: 1,
  status: OrderStatus.completed,
  rating: 5,
);

OrderModel exampleOrder9 = OrderModel(
  orderID: "orderModel9",
  itemID: "item9",
  itemPrice: 450.80,
  itemCount: 1,
  status: OrderStatus.confirmed,
  rating: 0,
);

OrderModel exampleOrder10 = OrderModel(
  orderID: "orderModel10",
  itemID: "item10",
  itemPrice: 200.50,
  itemCount: 1,
  status: OrderStatus.canceled,
  rating: 0,
);

OrderModel exampleOrder11 = OrderModel(
  orderID: "orderModel11",
  itemID: "item11",
  itemPrice: 150.25,
  itemCount: 1,
  status: OrderStatus.completed,
  rating: 4,
);

OrderModel exampleOrder12 = OrderModel(
  orderID: "orderModel12",
  itemID: "item12",
  itemPrice: 1800.99,
  itemCount: 1,
  status: OrderStatus.inTransit,
  rating: 0,
);

// List of example orders
List<OrderModel> exampleOrders = [
  exampleOrder1,
  exampleOrder2,
  exampleOrder3,
  exampleOrder4,
  exampleOrder5,
  exampleOrder6,
  exampleOrder7,
  exampleOrder8,
  exampleOrder9,
  exampleOrder10,
  exampleOrder11,
  exampleOrder12,
];
