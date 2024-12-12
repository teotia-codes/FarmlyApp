import 'package:app/farmer_direc/orders/model/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Function to retrieve orders by farmerID
Future<List<OrderModel>> getOrdersByFarmer(String farmerID) async {
  try {
    // Fetch orders where the 'farmerID' matches the provided farmerID
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('farmerID', isEqualTo: farmerID) // Filter by farmerID
        .get();

    // Convert the documents into a list of OrderModel objects
    List<OrderModel> orders = querySnapshot.docs.map((doc) {
      return OrderModel.fromFirestore(doc.data() as Map<String, dynamic>);
    }).toList();

    return orders;
  } catch (e) {
    print("Error retrieving orders by farmerID: $e");
    return [];
  }
}

