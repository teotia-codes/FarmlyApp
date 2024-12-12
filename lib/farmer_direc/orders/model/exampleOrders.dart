import 'package:app/farmer_direc/orders/model/order_model.dart';

// Example instances of OrderModel
OrderModel exampleOrder1 = OrderModel(
  orderID: "orderModel1",
  amount: 1500.75,
  itemID: "item1",
  itemName: "Wheat",
  itemPrice: 1500.75,
  itemCount: 1,
  status: OrderStatus.completed,
  rating: 5,
  farmerID: "farmerA123",
  retailerID: "retailerA123",
);

OrderModel exampleOrder2 = OrderModel(
  orderID: "orderModel2",
  amount: 800.50,
  itemID: "item2",
  itemName: "Rice",
  itemPrice: 800.50,
  itemCount: 1,
  status: OrderStatus.inTransit,
  rating: 0,
  farmerID: "farmerB456",
  retailerID: "retailerB456",
);

OrderModel exampleOrder3 = OrderModel(
  orderID: "orderModel3",
  amount: 1200.00,
  itemID: "item3",
  itemName: "Corn",
  itemPrice: 1200.00,
  itemCount: 1,
  status: OrderStatus.confirmed,
  rating: 0,
  farmerID: "farmerC789",
  retailerID: "retailerC789",
);

OrderModel exampleOrder4 = OrderModel(
  orderID: "orderModel4",
  amount: 250.25,
  itemID: "item4",
  itemName: "Barley",
  itemPrice: 250.25,
  itemCount: 1,
  status: OrderStatus.completed,
  rating: 4,
  farmerID: "farmerA123",
  retailerID: "retailerA123",
);

OrderModel exampleOrder5 = OrderModel(
  orderID: "orderModel5",
  amount: 500.50,
  itemID: "item5",
  itemName: "Soybeans",
  itemPrice: 500.50,
  itemCount: 1,
  status: OrderStatus.canceled,
  rating: 0,
  farmerID: "farmerB456",
  retailerID: "retailerB456",
);

OrderModel exampleOrder6 = OrderModel(
  orderID: "orderModel6",
  amount: 3000.00,
  itemID: "item6",
  itemName: "Peanuts",
  itemPrice: 3000.00,
  itemCount: 1,
  status: OrderStatus.completed,
  rating: 3,
  farmerID: "farmerC789",
  retailerID: "retailerC789",
);

OrderModel exampleOrder7 = OrderModel(
  orderID: "orderModel7",
  amount: 600.40,
  itemID: "item7",
  itemName: "Millet",
  itemPrice: 600.40,
  itemCount: 1,
  status: OrderStatus.inTransit,
  rating: 0,
  farmerID: "farmerA123",
  retailerID: "retailerA123",
);

OrderModel exampleOrder8 = OrderModel(
  orderID: "orderModel8",
  amount: 900.99,
  itemID: "item8",
  itemName: "Oats",
  itemPrice: 900.99,
  itemCount: 1,
  status: OrderStatus.completed,
  rating: 5,
  farmerID: "farmerB456",
  retailerID: "retailerB456",
);

OrderModel exampleOrder9 = OrderModel(
  orderID: "orderModel9",
  amount: 450.80,
  itemID: "item9",
  itemName: "Quinoa",
  itemPrice: 450.80,
  itemCount: 1,
  status: OrderStatus.confirmed,
  rating: 0,
  farmerID: "farmerC789",
  retailerID: "retailerC789",
);

OrderModel exampleOrder10 = OrderModel(
  orderID: "orderModel10",
  amount: 200.50,
  itemID: "item10",
  itemName: "Lentils",
  itemPrice: 200.50,
  itemCount: 1,
  status: OrderStatus.canceled,
  rating: 0,
  farmerID: "farmerA123",
  retailerID: "retailerA123",
);

OrderModel exampleOrder11 = OrderModel(
  orderID: "orderModel11",
  amount: 150.25,
  itemID: "item11",
  itemName: "Beans",
  itemPrice: 150.25,
  itemCount: 1,
  status: OrderStatus.completed,
  rating: 4,
  farmerID: "farmerB456",
  retailerID: "retailerB456",
);

OrderModel exampleOrder12 = OrderModel(
  orderID: "orderModel12",
  amount: 1800.99,
  itemID: "item12",
  itemName: "Chickpeas",
  itemPrice: 1800.99,
  itemCount: 1,
  status: OrderStatus.inTransit,
  rating: 0,
  farmerID: "farmerC789",
  retailerID: "retailerC789",
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
