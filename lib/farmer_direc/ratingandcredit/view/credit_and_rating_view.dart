
import 'package:app/farmer_direc/ratingandcredit/view/gauge_view.dart';
import 'package:app/utils/appcolors.dart';
import 'package:app/utils/texttheme.dart';
import 'package:flutter/material.dart';

class CreditAndRatingView extends StatelessWidget {
  const CreditAndRatingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      appBar: AppBar(
        title: Text(
          "TrueCredit™️ \nRating",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextPref.opensans
              .copyWith(fontWeight: FontWeight.bold, fontSize: 34),
        ),
        backgroundColor: AppColors.kBackground,
        elevation: 0,
        toolbarHeight: 150,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    "Current TrueCredit™️",
                    textAlign: TextAlign.left,
                    style: TextPref.opensans.copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              // Container to display TrueCredit score and explanation
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.PaleYellow,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SyncfusionGaugeView(label: "740"),
                        Positioned(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  // Icon(
                                  //   Icons.info_outline_rounded,
                                  //   color: Colors.grey[700],
                                  // ),
                                  // SizedBox(
                                  //   width: 5,
                                  // ),
                                  Text(
                                    "What is TrueCredit™️ ?",
                                    style: TextPref.opensans.copyWith(
                                        fontSize: 14,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Your TrueCredit™️ score combines your CIBIL score with crop quality and performance ratings. It prioritizes these factors over the CIBIL score for a more accurate credit assessment.",
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: TextPref.opensans.copyWith(
                                    fontSize: 14, color: Colors.grey[700]),
                              ),
                            ],
                          ),
                          top: 220,
                          left: 10,
                          right: 10,
                        )
                      ],
                    )

                    // Add spacing between gauge and text
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Text(
                    "Average Rating",
                    textAlign: TextAlign.left,
                    style: TextPref.opensans.copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ), // Add spacing between containers

              // Container to display Average Rating and explanation
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.PaleYellow,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Current Rating",
                          style: TextPref.opensans.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              Icons.star,
                              color: index < 4.5
                                  ? const Color.fromARGB(255, 255, 157, 59)
                                  : Colors.grey,
                            );
                          }),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "4.2",
                              style: TextPref.opensans.copyWith(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              "/5",
                              style: TextPref.opensans.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      "The Average Rating is based on retailer feedback and overall satisfaction with the produce provided.",
                      style: TextPref.opensans
                          .copyWith(fontSize: 16, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
