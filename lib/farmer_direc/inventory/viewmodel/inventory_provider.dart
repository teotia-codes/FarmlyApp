import 'package:app/farmer_direc/inventory/model/farmer_inventory_model.dart';
import 'package:flutter/material.dart';


class InventoryProvider extends ChangeNotifier {
  List<FarmerInventoryItem> _items = []; // Initialize with empty list

  List<FarmerInventoryItem> get items => _items; // Public getter for items

  // Initialize with a list of items (could be from an API or a database)
  InventoryProvider(List<FarmerInventoryItem> initialItems) {
    _items = initialItems;
    print("THIS IS PRINTED FROM THE PROVIDER\n" + _items.first.name.toString());
  }

  // Add an item
  void addItem(String name, double price, double kg) {
    final newItem = FarmerInventoryItem(
      name: name,
      price: price.toStringAsFixed(1),
      kgCount: kg.toString(),
      imageUrl:
          'default_image.jpg', // Set a default image or manage accordingly
    );

    _items.add(newItem);
    notifyListeners(); // Notify UI of the changes
  }

  // Remove an item
  void removeItem(FarmerInventoryItem item) {
    _items.remove(item);
    notifyListeners(); // Notify listeners to update the UI
  }

  // Edit an item
  void editItem(FarmerInventoryItem oldItem, FarmerInventoryItem newItem) {
    final index = _items.indexOf(oldItem);
    if (index != -1) {
      _items[index] = newItem;
      notifyListeners(); // Notify listeners to update the UI
    }
  }
}
