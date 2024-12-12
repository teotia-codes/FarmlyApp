// Function to retrieve orders by retailerID
import 'package:app/farmer_direc/orders/model/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<OrderModel>> getOrdersByRetailer(String retailerID) async {
  try {
    // Fetch orders where the 'retailerID' matches the provided retailerID
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('retailerID', isEqualTo: retailerID) // Filter by retailerID
        .get();

    // Convert the documents into a list of OrderModel objects
    List<OrderModel> orders = querySnapshot.docs.map((doc) {
      return OrderModel.fromFirestore(doc.data() as Map<String, dynamic>);
    }).toList();

    return orders;
  } catch (e) {
    print("Error retrieving orders by retailerID: $e");
    return [];
  }
}
