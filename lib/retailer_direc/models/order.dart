

class ROrderModel {
  String orderID;
  String itemID; // Unique ID for the item
  double itemPrice; // Price per item
  int itemCount; // Quantity of items
  OrderStatus status;
  int rating; // Only relevant for completed orders

  ROrderModel({
    required this.itemID,
    required this.itemPrice,
    required this.itemCount,
    required this.status,
    this.rating = 0,
    required this.orderID
  });

  Map<String, dynamic> toFirestore() {
    return {
      'itemID': itemID,
      'orderID':orderID,
      'itemPrice': itemPrice,
      'itemCount': itemCount,
      'status': status.toString().split('.').last,  // Store the status as a string
      'rating': rating,
    };
  }

  factory ROrderModel.fromFirestore(Map<String, dynamic> data) {
    return ROrderModel(
      orderID: data['orderID'],
      itemID: data['itemID'],
      itemPrice: data['itemPrice'],
      itemCount: data['itemCount'],
      status: OrderStatus.values.firstWhere((e) => e.toString().split('.').last == data['status']),
      rating: data['rating'],
    );
  }
}

enum OrderStatus {
  inTransit,
  completed,
  confirmed,
  canceled,
}
