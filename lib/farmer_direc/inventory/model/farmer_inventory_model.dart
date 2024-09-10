class FarmerInventoryItem {
  String itemId; // Unique ID for the inventory item
  String imageUrl; // URL of the inventory item image
  String name; // Name of the inventory item
  String price; // Price of the item
  String kgCount; // Weight in kilograms
  String farmerID; // Farmer's ID

  FarmerInventoryItem({
    required this.itemId,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.kgCount,
    required this.farmerID,
  });

  // Convert item to Firestore format
  Map<String, dynamic> toFirestore() {
    return {
      'itemId': itemId,
      'imageUrl': imageUrl,
      'name': name,
      'price': price,
      'kgCount': kgCount,
      'farmerID': farmerID,
    };
  }
}

// Example inventory items with itemId
List<FarmerInventoryItem> exampleInventoryItems = [
  FarmerInventoryItem(
    itemId: "item1", // You can manually define or auto-generate this ID
    name: "Generic Rice", 
    imageUrl: "rice.jpg", 
    price: "87", 
    kgCount: "23", 
    farmerID: "farmerA123"
  ),
  FarmerInventoryItem(
    itemId: "item2",
    name: "Tamarind", 
    imageUrl: "tamarind.jpg", 
    price: "246", 
    kgCount: "22", 
    farmerID: "farmerA123"
  ),
  FarmerInventoryItem(
    itemId: "item3",
    name: "Corn Kernel", 
    imageUrl: "corn.jpg", 
    price: "34", 
    kgCount: "50", 
    farmerID: "farmerA123"
  ),
  FarmerInventoryItem(
    itemId: "item4",
    name: "Cotton Seeds",
    imageUrl: "cotton.jpg",
    price: "485",
    kgCount: "34", 
    farmerID: "farmerB456"
  ),
  FarmerInventoryItem(
    itemId: "item5",
    name: "Coffee Beans",
    imageUrl: "coffee.jpg",
    price: "260",
    kgCount: "30",
    farmerID: "farmerB456"
  ),
  FarmerInventoryItem(
    itemId: "item6",
    name: "Soya Beans", 
    imageUrl: "soya.jpg", 
    price: "140", 
    kgCount: "43", 
    farmerID: "farmerB456"
  ),
  FarmerInventoryItem(
    itemId: "item7",
    name: "Tea", 
    imageUrl: "tea.jpg", 
    price: "367", 
    kgCount: "45", 
    farmerID: "farmerC789"
  ),
  FarmerInventoryItem(
    itemId: "item8",
    name: "Wheat", 
    imageUrl: "wheat.jpg", 
    price: "68", 
    kgCount: "130", 
    farmerID: "farmerC789"
  ),
  FarmerInventoryItem(
    itemId: "item9",
    name: "Soya Beans", 
    imageUrl: "soya.jpg", 
    price: "140", 
    kgCount: "43", 
    farmerID: "farmerC789"
  )
];
