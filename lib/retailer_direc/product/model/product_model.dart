import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String productId;
  String name;
  String description;
  double price;
  String category;
  String imageUrl;

  Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
  });

  // Convert Product to Firebase document
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
    };
  }

  // Create Product from Firebase document
  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Product(
      productId: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: data['price'] ?? 0.0,
      category: data['category'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}
