import 'dart:ui';

import 'package:app/farmer_direc/dashboard/model/commodity_model.dart';
import 'package:app/farmer_direc/dashboard/model/farmer_model.dart';
import 'package:app/farmer_direc/dashboard/view/inventory_scrollview_item.dart';
import 'package:app/farmer_direc/inventory/model/farmer_inventory_model.dart';
import 'package:app/farmer_direc/inventory/view/farmer_inventory_view.dart';
import 'package:app/farmer_direc/orders/view/order_view.dart';
import 'package:app/farmer_direc/orders/viewmodel/orderViewModel.dart';
import 'package:app/farmer_direc/ratingandcredit/view/credit_and_rating_view.dart';
import 'package:app/utils/appcolors.dart';
import 'package:app/utils/texttheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FarmerDashboardView extends StatefulWidget {
  const FarmerDashboardView({super.key});

  @override
  State<FarmerDashboardView> createState() => _FarmerDashboardViewState();
}

class _FarmerDashboardViewState extends State<FarmerDashboardView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: DashboardAppBar(size),
      backgroundColor: AppColors.kBackground,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 28, right: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Insights(size),
                SizedBox(
                  height: 30,
                ),
                LivePrices(size),
                SizedBox(
                  height: 30,
                ),
                Inventory(size),
                SizedBox(
                  height: 30,
                ),
                CreditAndRatingsCard(size),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column CreditAndRatingsCard(Size size) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "CREDIT AND RATINGS",
              textAlign: TextAlign.left,
              style: TextPref.opensans.copyWith(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
      SizedBox(
        height: 20,
      ),
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => CreditAndRatingView(
                    rating: "4.3",
                    value: 76,
                  )));
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          width: size.width * 0.85,
          height: size.height * 0.15,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 250, 235, 202)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        "TrueCredit™️",
                        style: TextPref.opensans.copyWith(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        " Score",
                        style: TextPref.opensans.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "740",
                        style: TextPref.opensans.copyWith(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade400),
                      ),
                      Text(
                        "/800",
                        style: TextPref.opensans.copyWith(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
              VerticalDivider(
                color: Colors.brown.shade300,
                thickness: 1.75,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Average Ratings",
                    style: TextPref.opensans
                        .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "4.2",
                        style: TextPref.opensans.copyWith(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightGreen.shade400),
                      ),
                      Text(
                        "/5",
                        style: TextPref.opensans.copyWith(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      )
    ]);
  }

  Column Inventory(Size size) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "YOUR INVENTORY",
            textAlign: TextAlign.left,
            style: TextPref.opensans.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: () {
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (_) => FarmerInventoryView()));
            },
            icon: Icon(
              Icons.chevron_right_rounded,
              size: 30,
              color: Colors.black,
            ),
          )
        ],
      ),
      SizedBox(
        height: 20,
      ),
      Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: size.width * 0.85,
              height: size.height * 0.2,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(
                  width: 10,
                ),
                itemBuilder: (context, index) =>
                    InventoryPriceColumn(size, exampleInventoryItems[index]),
                itemCount: exampleCommodities.length,
              ),
            ),
          )
        ],
      )
    ]);
  }

  Column LivePrices(Size size) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "LIVE PRICES",
        textAlign: TextAlign.left,
        style: TextPref.opensans.copyWith(
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: size.width * 0.85,
              height: size.height * 0.2,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(
                  width: 10,
                ),
                itemBuilder: (context, index) =>
                    LivePriceColumn(size, exampleCommodities[index]),
                itemCount: exampleCommodities.length,
              ),
            ),
          )
        ],
      )
    ]);
  }

  Column LivePriceColumn(Size size, CommodityModel commodity) {
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
                "assets/${commodity.url}",
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
                  '${commodity.name}', // Replace with dynamic text
                  style: TextPref.opensans.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "₹" +
                      '${commodity.price}' +
                      "/kg", // Replace with dynamic text
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

  Column Insights(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "INSIGHTS",
          textAlign: TextAlign.left,
          style: TextPref.opensans.copyWith(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.zero,
          height: size.height * 0.30,
          decoration: BoxDecoration(
              color: AppColors.kBackground,
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                width: size.width * 0.415,
                height: size.height * 0.3,
                decoration: BoxDecoration(
                    color: Colors.amber.shade300,
                    borderRadius: BorderRadius.circular(12.5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      height: size.height * 0.135,
                      width: size.width * 0.5,
                      decoration: BoxDecoration(
                          color: Colors.amber.shade100,
                          borderRadius: BorderRadius.circular(6.75)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Total Revenue",
                            textAlign: TextAlign.left,
                            style: TextPref.opensans.copyWith(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "₹" +
                                  exampleFarmer.revenueModel.totalRevenue
                                      .toStringAsFixed(1),
                              style: TextPref.opensans.copyWith(fontSize: 38),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      height: size.height * 0.130,
                      width: size.width * 0.5,
                      decoration: BoxDecoration(
                          color: Colors.amber.shade100,
                          borderRadius: BorderRadius.circular(6.75)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Profits Of",
                            textAlign: TextAlign.left,
                            style: TextPref.opensans.copyWith(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "₹${exampleFarmers.revenueModel.totalProfit.toStringAsFixed(1)}",
                              style: TextPref.opensans.copyWith(fontSize: 38),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => OrderView(
                                farmerId: "farmerA123",
                                initialSortOption: 'completed',
                              )));
                    },
                    child: Container(
                        padding: EdgeInsets.all(10),
                        width: size.width * 0.42,
                        height: size.height * 0.1455,
                        decoration: BoxDecoration(
                            color: AppColors.PastelGreen,
                            borderRadius: BorderRadius.circular(12.5)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Orders Delivered",
                              textAlign: TextAlign.left,
                              style: TextPref.opensans.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                exampleOrderViewModel
                                    .returnCompletedOrders()
                                    .toString(),
                                style: TextPref.opensans.copyWith(fontSize: 38),
                              ),
                            )
                          ],
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => OrderView(
                                farmerId: "farmerA123",
                                initialSortOption: 'inTransit',
                              )));
                    },
                    child: Container(
                      width: size.width * 0.42,
                      height: size.height * 0.1455,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: AppColors.PastelBeige,
                          borderRadius: BorderRadius.circular(12.5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "In Transit",
                            textAlign: TextAlign.left,
                            style: TextPref.opensans.copyWith(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              exampleOrderViewModel
                                  .returnInTransitOrders()
                                  .toString(),
                              style: TextPref.opensans.copyWith(fontSize: 38),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  AppBar DashboardAppBar(Size size) {
    return AppBar(
      backgroundColor: AppColors.kBackground,
      toolbarHeight: size.height * 0.1,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: size.height * 0.175,
              width: size.width * 0.175,
              child: Image.asset(
                "assets/farmhouse.png",
                alignment: Alignment.center,
                fit: BoxFit.contain,
              )),
          SizedBox(
            width: 2.5,
          ),
          Text(
            "FARMLY",
            textAlign: TextAlign.center,
            style: GoogleFonts.teko(
                color: Color(0xff046a38),
                fontSize: 28,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.5),
          )
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none_outlined),
            color: AppColors.kBrandColor,
            iconSize: 25,
          ),
        )
      ],
    );
  }
}
