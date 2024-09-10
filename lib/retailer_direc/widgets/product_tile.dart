import 'dart:async';


import 'package:app/retailer_direc/models/product.dart';
import 'package:app/retailer_direc/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ProductTile extends StatefulWidget {
   ProductTile({super.key, required this.cartItem});

  final Product cartItem;

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          IconlyLight.delete,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (direction) async {
        // if (direction == DismissDirection.endToStart) {
        //   return await showDialog(
        //     context: context,
        //     builder: (context) {
        //       return AlertDialog(
        //         title: const Text("Delete Item"),
        //         content: const Text(
        //           "Are you sure you want to delete this item?",
        //         ),
        //         actions: [
        //           TextButton(
        //             onPressed: () {
        //               Navigator.of(context).pop(false);
        //             },
        //             child: const Text("No"),
        //           ),
        //           TextButton(
        //             onPressed: () {
        //               Navigator.of(context).pop(true);
        //             },
        //             child: const Text("Yes"),
        //           ),
        //         ],
        //       );
        //     },
        //   );
        // }
        // return false;
        final completer = Completer<bool>();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            content: Text("Removed ${widget.cartItem.name} from cart?"),
            action: SnackBarAction(
              label: "Keep",
              onPressed: () {
                completer.complete(false);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );

        Timer(const Duration(seconds: 3), () {
          if (!completer.isCompleted) {
            completer.complete(true);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }
        });

        return await completer.future;
      },
      child: GestureDetector(
        onTap: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailsPage(product: widget.cartItem), // implement farmer model then push it
                            
                      ),
                    );},
        child: SizedBox(
          height: 170,
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
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  // IMAGE OF THE PRODUCT
                  Container(
                    width: 90,
                    height: double.infinity,
                    margin: const EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage("assets/${widget.cartItem.image}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
        
                  // OTHER INFORMATION
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.cartItem.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.cartItem.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 3,),
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              Icons.star,
                              color: index < widget.cartItem.rating
                                  ? Colors.orange
                                  : Colors.grey,
                              size: 16,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "₹${widget.cartItem.price}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
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
        
                            // SizedBox(
                            //   height: 30,
                            //   child: ToggleButtons(
                            //     onPressed: (index) {
                            //       if (index == 0) {
                            //         // USER WANT TO DECREASE QUANTITY
                            //       } else if (index == 2) {
                            //         // USER WANT TO INCREASE QUANTITY
                            //       }
                            //     },
                            //     borderRadius: BorderRadius.circular(99),
                            //     isSelected: const [true, false, true],
                            //     selectedColor:
                            //         Theme.of(context).colorScheme.primary,
                            //     constraints: const BoxConstraints(
                            //       minWidth: 30,
                            //       minHeight: 30,
                            //     ),
                            //     children: const [
                            //       Icon(Icons.remove, size: 20),
                            //       Text("2"),
                            //       Icon(Icons.add, size: 20),
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
