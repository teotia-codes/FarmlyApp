import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/retailer_direc/models/order.dart';
import 'package:app/utils/appcolors.dart';
import 'package:app/utils/texttheme.dart';
import 'package:flutter/material.dart';

class GiveRatingsScreen extends StatefulWidget {
  final String orderId;

  const GiveRatingsScreen({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  State<GiveRatingsScreen> createState() => _GiveRatingsScreenState();
}

class _GiveRatingsScreenState extends State<GiveRatingsScreen> {
  int _rating = 0;
  bool _isSubmitting = false;
  final TextEditingController _reviewController = TextEditingController();
  ROrderModel? _order;

  @override
  void initState() {
    super.initState();
    _fetchOrderDetails();
  }

  Future<void> _fetchOrderDetails() async {
    try {
      // Fetch the specific order using the order ID
      final docSnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .doc(widget.orderId)
          .get();

      if (docSnapshot.exists) {
        setState(() {
          _order = ROrderModel.fromFirestore(docSnapshot.data()!);
        });
      } else {
        // Handle case where order is not found
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Order not found')),
        );
      }
    } catch (e) {
      print('Error fetching order details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load order details')),
      );
    }
  }

  Future<void> _submitRating() async {
    if (_order == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order details not loaded')),
      );
      return;
    }

    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a rating before submitting.')),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Update the order document in Firestore
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(widget.orderId)
          .update({
        'rating': _rating,
        'reviewText': _reviewController.text.trim(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Rating submitted successfully!')),
      );
      Navigator.pop(context);
    } catch (e) {
      print('Error submitting rating: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit rating. Try again.')),
      );
    }

    setState(() {
      _isSubmitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_order == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Rate Order'),
          backgroundColor: AppColors.kBackground,
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Rate Order'),
        backgroundColor: AppColors.kBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${_order!.orderID}', style: TextPref.opensans),
            Text('Item: ${_order!.itemName}', style: TextPref.opensans),
            const SizedBox(height: 16),
            Text('Rate this order:', style: TextPref.opensans),
            Row(
              children: List.generate(
                5,
                (index) => IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () => setState(() => _rating = index + 1),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _reviewController,
              decoration: InputDecoration(
                labelText: 'Write a review (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isSubmitting ? null : _submitRating,
              style: ElevatedButton.styleFrom(
                iconColor: _rating > 0 ? Colors.green : Colors.grey,
              ),
              child: _isSubmitting
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Submit Rating'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }
}