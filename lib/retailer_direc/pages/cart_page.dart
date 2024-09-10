
import 'package:app/razorpay/razorpay.dart';
import 'package:app/retailer_direc/data/product.dart';
import 'package:app/retailer_direc/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItems = exampleProducts.take(4).toList();
    final totalPrice =
        cartItems.map((e) => e.price).reduce((acc, cur) => acc + cur);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // LIST OF CART ITEMS SPREAD OUT IN THE VIEW
          ...List.generate(cartItems.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: CartItemWidget(cartItem: cartItems[index]),
            );
          }),
          // TOTAL ITEMS IN CART AS WELL AS TOTAL PRICE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total: (${cartItems.length})"),
              Text(
                "₹$totalPrice",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
          // CHECKOUT BUTTON
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=> RazorPayPage()));
            },
            icon: const Icon(IconlyBold.arrowRight),
            label: const Text("Proceed to Checkout"),
          ),
        ],
      ),
    );
  }
}
