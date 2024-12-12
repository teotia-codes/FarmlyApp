import 'package:flutter/material.dart';

class ToolsSharingScreen extends StatefulWidget {
  @override
  _ToolsSharingScreenState createState() => _ToolsSharingScreenState();
}

class _ToolsSharingScreenState extends State<ToolsSharingScreen> {
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

  void _addTool() {
    showDialog(
      context: context,
      builder: (context) {
        final toolNameController = TextEditingController();
        final availabilityController = TextEditingController();
        final ownerController = TextEditingController();

        return AlertDialog(
          title: const Text('Add New Tool'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: toolNameController,
                  decoration: const InputDecoration(labelText: 'Tool Name'),
                ),
                TextField(
                  controller: availabilityController,
                  decoration: const InputDecoration(labelText: 'Availability'),
                ),
                TextField(
                  controller: ownerController,
                  decoration: const InputDecoration(labelText: 'Owner'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final toolName = toolNameController.text.trim();
                final availability = availabilityController.text.trim();
                final owner = ownerController.text.trim();

                if (toolName.isNotEmpty &&
                    availability.isNotEmpty &&
                    owner.isNotEmpty) {
                  setState(() {
                    tools.add({
                      'toolName': toolName,
                      'availability': availability,
                      'owner': owner,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tools Sharing'),
      ),
      body: ListView.builder(
        itemCount: tools.length,
        itemBuilder: (context, index) {
          var tool = tools[index];

          return Card(
            margin: const EdgeInsets.all(10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: const Icon(Icons.build, size: 50, color: Colors.orange),
              title: Text(
                tool['toolName'],
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _addTool,
        child: const Icon(Icons.add),
      ),
    );
  }
}
