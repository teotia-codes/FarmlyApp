
class FarmerInventoryItem {
  String imageUrl; // URL of the inventory item image
  String name; // Name of the inventory item
  String price; // Price of the item
  String kgCount; // Weight in kilograms

  FarmerInventoryItem({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.kgCount,
  });
}

List<FarmerInventoryItem> exampleInventoryItems = [
  FarmerInventoryItem(
      name: "Generic Rice", imageUrl: "rice.jpg", price: "87", kgCount: "23"),
  FarmerInventoryItem(
      name: "Tamarind", imageUrl: "tamarind.jpg", price: "246", kgCount: "22"),
  FarmerInventoryItem(
      name: "Corn Kernel", imageUrl: "corn.jpg", price: "34", kgCount: "50"),
  FarmerInventoryItem(
      name: "Cotton Seeds",
      imageUrl: "cotton.jpg",
      price: "485",
      kgCount: "34"),
  FarmerInventoryItem(
      name: "Coffee Beans",
      imageUrl: "coffee.jpg",
      price: "260",
      kgCount: "30"),
  FarmerInventoryItem(
      name: "Soya Beans", imageUrl: "soya.jpg", price: "140", kgCount: "43"),
  FarmerInventoryItem(
      name: "Tea", imageUrl: "tea.jpg", price: "367", kgCount: "45"),
  FarmerInventoryItem(
      name: "Wheat", imageUrl: "wheat.jpg", price: "68", kgCount: "130"),
];
