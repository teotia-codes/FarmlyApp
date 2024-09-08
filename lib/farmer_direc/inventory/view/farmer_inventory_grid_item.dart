import 'package:app/farmer_direc/inventory/model/farmer_inventory_model.dart';
import 'package:app/utils/texttheme.dart';
import 'package:flutter/material.dart';


class InventoryGridItem extends StatelessWidget {
  final FarmerInventoryItem item;
  final bool isEditMode;
  final VoidCallback onRemove;

  InventoryGridItem({
    Key? key,
    required this.item,
    required this.isEditMode,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      // Duration of the animation
      child: !isEditMode
          ? Stack(
              key: ValueKey<bool>(isEditMode), // Unique key for the edit mode
              children: [
                // Image as background
                Container(
                  width: size.width * 0.30,
                  height: size.height * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.5),
                    child: Image.asset(
                      "assets/${item.imageUrl}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Greyish gradient overlay
                Container(
                  width: size.width * 0.30,
                  height: size.height * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.5),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent, // Transparent at the top
                        Colors.black.withOpacity(
                            0.6), // Greyish gradient towards the bottom
                      ],
                      stops: [0.35, 0.85], // Gradient stops
                    ),
                  ),
                ),
                // Text at the bottom half
                Positioned(
                  bottom: 16.0, // Position text at the bottom
                  left: 8.0,
                  right: 8.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: TextPref.opensans.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "₹${item.price}/kg",
                        style: TextPref.opensans.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "${item.kgCount} kgs",
                        style: TextPref.opensans.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Stack(
              key: ValueKey<bool>(
                  isEditMode), // Unique key for the non-edit mode
              children: [
                // Image as background
                Container(
                  width: size.width * 0.275,
                  height: size.height * 0.125,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.5),
                    child: Image.asset(
                      "assets/${item.imageUrl}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Greyish gradient overlay
                Container(
                  width: size.width * 0.275,
                  height: size.height * 0.125,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.5),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent, // Transparent at the top
                        Colors.black.withOpacity(
                            0.6), // Greyish gradient towards the bottom
                      ],
                      stops: [0.35, 0.85], // Gradient stops
                    ),
                  ),
                ),
                // Text at the bottom half
                Positioned(
                  bottom: 16.0, // Position text at the bottom
                  left: 8.0,
                  right: 8.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: TextPref.opensans.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "₹${item.price}/kg",
                        style: TextPref.opensans.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "${item.kgCount} kgs",
                        style: TextPref.opensans.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -9, // Adjust top padding from the top edge
                  right: 0,
                  left: 72, // Adjust right padding from the right edge
                  child: IconButton(
                    onPressed: onRemove, // Use the callback
                    icon: Icon(
                      Icons.do_not_disturb_on_total_silence_outlined,
                      color: Colors.red.shade700,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
