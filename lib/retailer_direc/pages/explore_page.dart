import 'package:app/farmer_direc/inventory/model/farmer_inventory_model.dart';
import 'package:app/provider/farmer/farmer_provider.dart';
import 'package:app/retailer_direc/components/offers_carousel.dart';
import 'package:app/retailer_direc/models/product.dart';
import 'package:app/retailer_direc/widgets/filter_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../widgets/product_card.dart';


class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    FarmerProvider farmerProvider = Provider.of<FarmerProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // FILTER AND SEARCH TEXT FIELD
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search here...',
                        isDense: true,
                        contentPadding: const EdgeInsets.all(12),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(99),
                          ),
                        ),
                        prefixIcon: const Icon(IconlyLight.search),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: IconButton.filled(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return  FilterDialog();
                          },
                        );
                      },
                      icon: const Icon(IconlyLight.filter),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const OffersCarousel(),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Featured Products",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("See all"),
                ),
              ],
            ),

            // FEATURED PRODUCTS FROM FARMER INVENTORY
            FutureBuilder<List<FarmerInventoryItem>>(
              future: farmerProvider.getInventoryList('farmerA123'),  // Fetch inventory for specific farmer
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Failed to load products.'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No products available.'));
                }

                // If inventory items are fetched successfully
                List<FarmerInventoryItem> inventoryItems = snapshot.data!;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: inventoryItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final item = inventoryItems[index];
                    return ProductCard(
                      product: Product(name: item.name, farmer: item.farmerID, description: "NULL", image: item.imageUrl, price: item.price , unit: "1", rating: 0),  // Update the `ProductCard` to accept a FarmerInventoryItem if needed
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
