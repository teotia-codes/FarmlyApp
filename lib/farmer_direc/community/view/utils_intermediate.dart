import 'package:app/farmer_direc/community/view/crowdfunding_community.dart';
import 'package:app/farmer_direc/community/view/monthly_deliveries.dart';
import 'package:app/farmer_direc/community/view/selling.dart';
import 'package:app/farmer_direc/community/view/sharing.dart';
import 'package:app/farmer_direc/community/view/transport.dart';
import 'package:flutter/material.dart';


class UtilsScreenCommunity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmer Community Dashboard'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        padding: EdgeInsets.all(20),
        children: [
          _buildGridItem(context, 'Collective Selling', Icons.sell, CollectiveSellingScreen()),
          _buildGridItem(context, 'Tools Sharing', Icons.build, ToolsSharingScreen()),
          _buildGridItem(context, 'Crowdfunding', Icons.monetization_on, CrowdfundingCommunity()),
          _buildGridItem(context, 'Transport & Logistics', Icons.local_shipping, TransportLogisticsScreen()),
          _buildGridItem(context, 'Monthly Deliveries', Icons.calendar_today, MonthlyDeliveriesScreen()),
        ],
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, String title, IconData icon, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightGreen[100],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 100, color: Colors.green),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
