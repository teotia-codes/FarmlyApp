import 'package:app/farmer_direc/orders/model/order_model.dart'; 
import 'package:app/farmer_direc/orders/viewmodel/orderViewModel.dart';
import 'package:app/retailer_direc/data/product.dart';
import 'package:app/retailer_direc/models/ROrderViewModel.dart'; 
import 'package:app/retailer_direc/models/order.dart' as Rorder;
import 'package:app/retailer_direc/models/product.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:app/farmerinfo.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool showingMore = false;
  late TapGestureRecognizer readMoreGestureRecognizer;
  final Uuid uuid = Uuid(); // Create an instance of Uuid

  @override
  void initState() {
    readMoreGestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          showingMore = !showingMore;
        });
      };
    super.initState();
  }

  @override
  void dispose() {
    readMoreGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final rOrderProvider = Provider.of<ROrderProvider>(context, listen: false);

    // Ensure that price is parsed to double
    final double price = double.tryParse(widget.product.price) ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(IconlyBroken.bookmark),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 250,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage("assets/${widget.product.image}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            widget.product.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FarmerInfo(), // Implement farmer model then push it
                      ),
                    );
                  },
                  child: Text(
                    "by ${widget.product.farmer}",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Available in stock",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "₹$price",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    TextSpan(
                      text: " / ${widget.product.unit}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.star,
                size: 16,
                color: Colors.yellow.shade600,
              ),
              Text("${widget.product.rating} (192)"),
              const Spacer(),
              SizedBox(
                width: 30,
                height: 30,
                child: IconButton.filled(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  iconSize: 18,
                  icon: const Icon(Icons.remove),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "1 ${widget.product.unit}",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              SizedBox(
                width: 30,
                height: 30,
                child: IconButton.filled(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  iconSize: 18,
                  icon: const Icon(Icons.add),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "Description",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: showingMore
                      ? widget.product.description
                      : widget.product.description.substring(0, widget.product.description.length),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Related Products",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 90,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(exampleProducts[index].image),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemCount: exampleProducts.length,
            ),
          ),
          const SizedBox(height: 10),
          FilledButton.icon(
            onPressed: () async {
              try {
                final order = OrderModel(
                  orderID: uuid.v4(), // Generate a unique order ID
                  itemID: uuid.v4(), // Generate a unique item ID
                  itemPrice: price, // Use the parsed double
                  itemCount: 1,
                  status: OrderStatus.inTransit, // Set appropriate status
                );

                final rorder = Rorder.ROrderModel(
                  orderID: uuid.v4(), // Generate a unique order ID
                  itemID: uuid.v4(), // Generate a unique item ID
                  itemPrice: price, // Use the parsed double
                  itemCount: 1,
                  status: Rorder.OrderStatus.inTransit, // Set appropriate status
                );

                // Add order to farmer's collection
                await orderProvider.addOrder('farmerA123', order);

                // Add order to retailer's collection
                await rOrderProvider.addOrder('retailerA123', rorder);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Order placed successfully!')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to place order: $e')),
                );
              }
            },
            icon: const Icon(IconlyLight.bag2),
            label: const Text("Buy"),
          ),
        ],
      ),
    );
  }
}
