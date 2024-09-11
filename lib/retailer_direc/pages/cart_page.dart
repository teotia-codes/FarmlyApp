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
    final totalPriceString =
        cartItems.map((e) => e.price).reduce((acc, cur) => (double.parse(acc) + double.parse(cur)).toString());

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
                "₹${formatStringToTwoDecimalPoints(totalPriceString)}",
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
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RazorPayPage(formatStringToTwoDecimalPoints(totalPriceString),),
      ),
    );
  },
  icon: const Icon(IconlyBold.arrowRight),
  label: const Text("Proceed to Checkout"),
),

        ],
      ),
    );
  }

  String formatStringToTwoDecimalPoints(String value) {
    try {
      // Convert the string to double
      double doubleValue = double.parse(value);

      // Round and convert to string with two decimal places
      return doubleValue.toStringAsFixed(2);
    } catch (e) {
      // Handle any parsing errors
      print("Error formatting price: $e");
      return value; // Return the original value in case of error
    }
  }
}