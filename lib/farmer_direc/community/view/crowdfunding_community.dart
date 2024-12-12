import 'package:flutter/material.dart';

class CrowdfundingCommunity extends StatelessWidget {
  final List<Map<String, dynamic>> projects = [
    {
      'name': 'Organic Vegetable Farm Expansion',
      'goal': 50000,
      'currentFunding': 25000,
      'deadline': '2024-06-30',
    },
    {
      'name': 'Tool Sharing Initiative for Farmers',
      'goal': 30000,
      'currentFunding': 18000,
      'deadline': '2024-07-15',
    },
    {
      'name': 'Improving Irrigation Systems',
      'goal': 40000,
      'currentFunding': 32000,
      'deadline': '2024-08-01',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crowdfunding Projects'),
      ),
      body: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          var project = projects[index];

          return Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: Icon(Icons.monetization_on, size: 50, color: Colors.green),
              title: Text(
                project['name'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Funding Goal: ₹${project['goal']}'),
                  Text('Current Funding: ₹${project['currentFunding']}'),
                  Text('Deadline: ${project['deadline']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
