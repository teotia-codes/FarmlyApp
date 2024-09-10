
import 'package:app/retailer_direc/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../models/product.dart';

class ProductCard extends StatefulWidget {
  ProductCard({super.key, required this.product});

  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(product: widget.product),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          side: BorderSide(
            color: Colors.grey.shade400,
            width: 0.2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/${widget.product.image}"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton.filledTonal(
                      onPressed: () {
                       
                      },
                      iconSize: 18,
                      icon: const Icon(IconlyLight.bookmark),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    widget.product.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 4),
                //   child: Text(
                //     "by ${product.farmer}",
                //     style: Theme.of(context).textTheme.bodyLarge,
                //   ),
                // ),
                // SizedBox(height: 4),
                // Ratings
                Padding(
                  padding: const EdgeInsets.only(left:4.0),
                  child: Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        Icons.star,
                        color:
                            index < widget.product.rating ? Colors.orange : Colors.grey,
                        size: 16,
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "\₹${widget.product.price}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            // TextSpan(
                            //   text: " / ${product.unit}",
                            //   style: Theme.of(context).textTheme.bodySmall,
                            // ),
                          ],
                        ),
                      ),
                      quantity == 0
                          ? IconButton.filled(
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              icon: const Icon(Icons.add),
                            )
                          : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 4),
                            child: SizedBox(
                                height: 30,
                                child: ToggleButtons(
                                  onPressed: (index) {
                                    if (index == 0) {
                                      // USER WANT TO DECREASE QUANTITY
                                    } else if (index == 2) {
                                      // USER WANT TO INCREASE QUANTITY
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(99),
                                  isSelected: const [true, false, true],
                                  selectedColor:
                                      Theme.of(context).colorScheme.primary,
                                  constraints: const BoxConstraints(
                                    minWidth: 30,
                                    minHeight: 30,
                                  ),
                                  children: const [
                                    Icon(Icons.remove, size: 20),
                                    Text("2"),
                                    Icon(Icons.add, size: 20),
                                  ],
                                ),
                              ),
                          )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
