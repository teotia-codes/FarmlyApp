class ROrderModel {
  String orderID;
  String farmerID;
  String retailerID;
  String itemID;
  String itemName;
  double itemPrice;
  int itemCount;
  OrderStatus status;
  int rating;

  ROrderModel({
    required this.orderID,
    required this.farmerID,
    required this.retailerID,
    required this.itemID,
    required this.itemName,
    required this.itemPrice,
    required this.itemCount,
    required this.status,
    this.rating = 0,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'orderID': orderID,
      'farmerID': farmerID,
      'retailerID': retailerID,
      'itemID': itemID,
      'itemName': itemName,
      'itemPrice': itemPrice,
      'itemCount': itemCount,
      'status': status.toString().split('.').last,
      'rating': rating,
    };
  }

  factory ROrderModel.fromFirestore(Map<String, dynamic> data) {
    return ROrderModel(
      orderID: _parseString(data, 'orderID', defaultValue: 'unknown'),
      farmerID: _parseString(data, 'farmerID', defaultValue: 'unknown'),
      retailerID: _parseString(data, 'retailerID', defaultValue: 'unknown'),
      itemID: _parseString(data, 'itemID', defaultValue: 'unknown'),
      itemName: _parseString(data, 'itemName', defaultValue: 'Unnamed Item'),
      itemPrice: _parseDouble(data, 'itemPrice', defaultValue: 0.0),
      itemCount: _parseInt(data, 'itemCount', defaultValue: 0),
      status: _parseStatus(data['status']),
      rating: _parseInt(data, 'rating', defaultValue: 0),
    );
  }

  double get totalAmount {
    return itemPrice * itemCount;
  }

  // Utility method to parse string with a default value
  static String _parseString(Map<String, dynamic> data, String key, {String defaultValue = ''}) {
    return (data[key] is String) ? data[key] : defaultValue;
  }

  // Utility method to parse double with a default value
  static double _parseDouble(Map<String, dynamic> data, String key, {double defaultValue = 0.0}) {
    if (data[key] is int) return (data[key] as int).toDouble();
    return (data[key] is double) ? data[key] : defaultValue;
  }

  // Utility method to parse int with a default value
  static int _parseInt(Map<String, dynamic> data, String key, {int defaultValue = 0}) {
    if (data[key] is double) return (data[key] as double).toInt();
    return (data[key] is int) ? data[key] : defaultValue;
  }

  // Utility method to parse status with a fallback
  static OrderStatus _parseStatus(dynamic status) {
    if (status == null) return OrderStatus.confirmed;
    
    try {
      return OrderStatus.values.firstWhere(
        (e) => e.toString().split('.').last == status,
        orElse: () => OrderStatus.confirmed
      );
    } catch (e) {
      return OrderStatus.confirmed;
    }
  }
}

enum OrderStatus {
  inTransit,
  completed,
  confirmed,
  canceled,
}