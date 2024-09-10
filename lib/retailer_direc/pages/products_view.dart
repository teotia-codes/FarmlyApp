import 'package:agriculture/widgets/filter_dialog_widget.dart';
import 'package:agriculture/widgets/product_card.dart';
import 'package:agriculture/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import '../data/product.dart';

import 'package:flutter_iconly/flutter_iconly.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  bool isListView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            //FILTER AND SEARCH TEXT FIELD
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
                            return FilterDialog();
                          },
                        );
                      },
                      icon: const Icon(IconlyLight.filter),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "All Products",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    isListView? const Icon(Icons.list) : const  Icon(Icons.grid_on),
                    // Text(
                    //   "List  ",
                    //   style: Theme.of(context).textTheme.bodyLarge,
                    // ),
                    Switch(
                      value: isListView,
                      onChanged: (value) {
                        setState(() {
                          isListView = value;
                        });
                      },
                      activeColor: Colors.white,
                      activeTrackColor: Colors.lightGreen,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
            isListView ? ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductTile(cartItem: products[index]);
              },
            ) : GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            ),

          ],
        ),
      ),
    );
  }
}
