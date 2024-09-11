import 'package:app/farmer_direc/inventory/model/farmer_inventory_model.dart';
import 'package:app/farmer_direc/inventory/view/farmer_inventory_grid_item.dart';
import 'package:app/farmer_direc/inventory/viewmodel/inventory_provider.dart';
import 'package:app/provider/farmer/farmer_provider.dart';
import 'package:app/utils/appcolors.dart';
import 'package:app/utils/texttheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FarmerInventoryView extends StatefulWidget {
  const FarmerInventoryView({
    super.key,
  });

  @override
  State<FarmerInventoryView> createState() => _FarmerInventoryViewState();
}

class _FarmerInventoryViewState extends State<FarmerInventoryView> {
  bool isEditToggled = false;
 

  @override
  Widget build(BuildContext context) {
    FarmerProvider farmerProvider = Provider.of<FarmerProvider>(context, listen: true);
    

    return Scaffold(
      backgroundColor: AppColors.kBackground,
      appBar: AppBar(
        title: Text(
          'Your Inventory',
          textAlign: TextAlign.center,
          style: TextPref.opensans.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.kBackground,
        foregroundColor: Colors.black,
      ),
      body: FutureBuilder<List<FarmerInventoryItem>>(
        future: farmerProvider.getInventoryList('farmerA123'),  // Awaiting the async function
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading inventory'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No inventory items available'));
          }

          List<FarmerInventoryItem> listofItems = snapshot.data!;

          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const SizedBox(height: 16),

                // Grid view showing farmer inventory items
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: listofItems.length,
                    itemBuilder: (context, index) {
                      final item = listofItems[index];
                      return InventoryGridItem(
                        item: item,
                        isEditMode: isEditToggled,
                        onRemove: () {
                          farmerProvider.deleteInventoryItem('farmerA123', item.itemId);
                        },
                      );
                    },
                  ),
                ),

                // Edit and Add buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isEditToggled = !isEditToggled;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 65, 43, 3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      ),
                      child: Text(
                        isEditToggled ? 'Done' : 'Edit Inventory',
                        style: TextPref.opensans.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () async {
  await showDialog(
    context: context,
    builder: (context) {
      final nameController = TextEditingController();
      final priceController = TextEditingController();
      final kgController = TextEditingController();
      final itemIdController = TextEditingController();  // New controller for itemId

      return AlertDialog(
        backgroundColor: AppColors.kBackground,
        title: Text("Add New Item"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: itemIdController,  // Field for itemId
                decoration: InputDecoration(
                  labelText: 'Item ID',
                ),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Item Name',
                ),
              ),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Price (₹/kg)',
                ),
              ),
              TextField(
                controller: kgController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Quantity (kgs)',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (itemIdController.text.isNotEmpty &&
                  nameController.text.isNotEmpty &&
                  priceController.text.isNotEmpty &&
                  kgController.text.isNotEmpty) {
                final itemId = itemIdController.text;
                final name = nameController.text;
                final price = double.tryParse(priceController.text);
                final kg = double.tryParse(kgController.text);

                if (price != null && kg != null)  {
                  await farmerProvider.addInventoryItems(
                    "farmerA123",
                    FarmerInventoryItem(
                      itemId: itemId,
                     imageUrl: "rice.jpg",
                      name: name,
                      price: price.toString(),
                      kgCount: kg.toString(),
                      farmerID: "farmerA123",
                    ),
                  );
                  Navigator.of(context).pop();
                }
              }
            },
            child: Text(
              "Add",
              style: TextPref.opensans.copyWith(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Cancel",
              style: TextPref.opensans.copyWith(color: Colors.black),
            ),
          ),
        ],
      );
    },
  );
},

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 65, 43, 3),
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(4),
                      ),
                      child: const Icon(
                        Icons.add_business_outlined,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
