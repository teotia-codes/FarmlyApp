class OrderModel {
  String orderID;
  double amount; // Total amount for the order
  String itemID; // Unique ID for the item
  String itemName; // Name of the item
  double itemPrice; // Price per item
  int itemCount; // Quantity of items
  OrderStatus status;
  int rating; // Rating (only relevant for completed orders)
  String farmerID; // Farmer ID
  String retailerID; // Retailer ID

  OrderModel({
    required this.orderID,
    required this.amount,
    required this.itemID,
    required this.itemName,
    required this.itemPrice,
    required this.itemCount,
    required this.status,
    this.rating = 0,
    required this.farmerID,
    required this.retailerID,
  });

  // Convert OrderModel to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'amount': amount,
      'orderID': orderID,
      'item': {
        'itemID': itemID,
        'itemName': itemName,
        'itemPrice': itemPrice,
        'itemCount': itemCount,
      },
      'status': status.toString().split('.').last, // Store status as a string
      'rating': rating,
      'farmerID': farmerID,
      'retailerID': retailerID,
    };
  }

  // Factory method to create OrderModel from Firestore data
  factory OrderModel.fromFirestore(Map<String, dynamic> data) {
    var itemData = data['item'] ?? {};
    return OrderModel(
      orderID: data['orderID'],
      amount: data['amount'],
      itemID: itemData['itemID'],
      itemName: itemData['itemName'],
      itemPrice: itemData['itemPrice'],
      itemCount: itemData['itemCount'],
      status: OrderStatus.values.firstWhere(
          (e) => e.toString().split('.').last == data['status']),
      rating: data['rating'] ?? 0, // Default rating to 0 if null
      farmerID: data['farmerID'],
      retailerID: data['retailerID'],
    );
  }
}

// Enum for OrderStatus
enum OrderStatus {
  inTransit,
  completed,
  confirmed,
  canceled,
}
