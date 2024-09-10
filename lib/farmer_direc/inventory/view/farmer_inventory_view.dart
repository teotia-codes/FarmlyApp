
import 'package:app/farmer_direc/inventory/model/exampleInventory.dart';
import 'package:app/farmer_direc/inventory/view/farmer_inventory_grid_item.dart';
import 'package:app/farmer_direc/inventory/viewmodel/inventory_provider.dart';
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
    final inventoryProvider =
        Provider.of<InventoryProvider>(context, listen: true);

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
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Edit and Add buttons
            const SizedBox(height: 16),

            // Grid view taking the rest of the space
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: inventoryProvider.items.length,
                itemBuilder: (context, index) {
                  final item = inventoryProvider.items[index];
                  return InventoryGridItem(
                    item: item,
                    isEditMode: isEditToggled,
                    onRemove: () => inventoryProvider.removeItem(item),
                  );
                },
              ),
            ),
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

                        return AlertDialog(
                          backgroundColor: AppColors.kBackground,
                          title: Text("Add New Item"),
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
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
                              onPressed: () {
                                if (nameController.text.isNotEmpty &&
                                    priceController.text.isNotEmpty &&
                                    kgController.text.isNotEmpty) {
                                  final name = nameController.text;
                                  final price =
                                      double.tryParse(priceController.text);
                                  final kg = double.tryParse(kgController.text);

                                  if (price != null && kg != null) {
                                    context
                                        .read<InventoryProvider>()
                                        .addItem("1",name, price, kg, "12");
                                    Navigator.of(context).pop();
                                  }
                                }
                              },
                              child: Text(
                                "Add",
                                style: TextPref.opensans
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancel",
                                  style: TextPref.opensans
                                      .copyWith(color: Colors.black)),
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
                  child: Icon(
                    Icons.add_business_outlined,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}























