import 'package:app/retailer_direc/models/order.dart';
import 'package:app/retailer_direc/pages/cross_rating.dart';
import 'package:app/utils/appcolors.dart';
import 'package:app/utils/texttheme.dart';
import 'package:flutter/material.dart';

class GiveRatingsScreen extends StatefulWidget {
  final ROrderModel order;
  final String retailerId;
  final String farmerId;

  const GiveRatingsScreen({
    Key? key,
    required this.order,
    required this.retailerId,
    required this.farmerId,
  }) : super(key: key);

  @override
  State<GiveRatingsScreen> createState() => _GiveRatingsScreenState();
}

class _GiveRatingsScreenState extends State<GiveRatingsScreen> {
  int _rating = 0;
  bool _isSubmitting = false;
  final TextEditingController _reviewController = TextEditingController();
  final CrossCollectionRatingService _ratingService = CrossCollectionRatingService();

  Future<void> _submitRating() async {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a rating before submitting.')),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final success = await _ratingService.submitCrossCollectionRating(
      retailerId: widget.retailerId,
      farmerId: widget.farmerId,
      retailerOrderId: widget.order.orderID,
      itemId: widget.order.itemID,
      rating: _rating,
      reviewText: _reviewController.text.trim(),
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Rating submitted successfully!')),
      );
      Navigator.pop(context);
    } else {
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
            Text('Order ID: ${widget.order.orderID}', style: TextPref.opensans),
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
