// Example orders
import 'package:app/retailer_direc/models/order.dart';

ROrderModel order1 = ROrderModel(
  orderID: "order001",
  itemID: "item1",
  itemPrice: 87.0,
  itemCount: 5,
  status: OrderStatus.completed,
  rating: 4, // Provided rating for completed orders
);

ROrderModel order2 = ROrderModel(
  orderID: "order002",
  itemID: "item2",
  itemPrice: 246.0,
  itemCount: 3,
  status: OrderStatus.inTransit,
);

ROrderModel order3 = ROrderModel(
  orderID: "order003",
  itemID: "item4",
  itemPrice: 485.0,
  itemCount: 2,
  status: OrderStatus.confirmed,
);

ROrderModel order4 = ROrderModel(
  orderID: "order004",
  itemID: "item5",
  itemPrice: 260.0,
  itemCount: 1,
  status: OrderStatus.canceled,
);

ROrderModel order5 = ROrderModel(
  orderID: "order005",
  itemID: "item7",
  itemPrice: 367.0,
  itemCount: 10,
  status: OrderStatus.completed,
  rating: 5, // Provided rating for completed orders
);
