import 'dart:ui';

import 'package:app/farmer_direc/inventory/model/farmer_inventory_model.dart';
import 'package:app/utils/texttheme.dart';
import 'package:flutter/material.dart';

Column InventoryPriceColumn(Size size, FarmerInventoryItem item) {
  return Column(
    children: [
      Stack(children: [
        // Image as background
        Container(
          width: size.width * 0.35,
          height: size.height * 0.2,
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
          width: size.width * 0.35,
          height: size.height * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.5),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent, // Transparent at the top
                Color.fromARGB(255, 32, 32, 32)
                    .withOpacity(0.6), // Greyish gradient towards the bottom
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
                '${item.name}', // Replace with dynamic text
                style: TextPref.opensans.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "₹" + '${item.price}' + "/kg", // Replace with dynamic text
                style: TextPref.opensans.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${item.kgCount} kgs", // Replace with dynamic text
                style: TextPref.opensans.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ])
    ],
  );
}
