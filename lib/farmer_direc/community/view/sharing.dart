import 'package:flutter/material.dart';

class ToolsSharingScreen extends StatelessWidget {
  final List<Map<String, dynamic>> tools = [
    {
      'toolName': 'Plough',
      'availability': 'Available',
      'owner': 'Farmer A',
    },
    {
      'toolName': 'Harvest Machine',
      'availability': 'Not Available',
      'owner': 'Farmer B',
    },
    {
      'toolName': 'Sprayer',
      'availability': 'Available',
      'owner': 'Farmer C',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tools Sharing'),
      ),
      body: ListView.builder(
        itemCount: tools.length,
        itemBuilder: (context, index) {
          var tool = tools[index];

          return Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: Icon(Icons.build, size: 50, color: Colors.orange),
              title: Text(
                tool['toolName'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Availability: ${tool['availability']}'),
                  Text('Owner: ${tool['owner']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
