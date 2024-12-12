import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CrowdfundingCommunity extends StatefulWidget {
  @override
  _CrowdfundingCommunityState createState() => _CrowdfundingCommunityState();
}

class _CrowdfundingCommunityState extends State<CrowdfundingCommunity> {
  final List<Map<String, dynamic>> projects = [
    {
      'name': 'Organic Vegetable Farm Expansion',
      'goal': 50000,
      'currentFunding': 25000,
      'deadline': '2024-06-30',
      'uuid': Uuid().v4()
    },
    {
      'name': 'Tool Sharing Initiative for Farmers',
      'goal': 30000,
      'currentFunding': 18000,
      'deadline': '2024-07-15',
      'uuid': Uuid().v4()
    },
    {
      'name': 'Improving Irrigation Systems',
      'goal': 40000,
      'currentFunding': 32000,
      'deadline': '2024-08-01',
      'uuid': Uuid().v4()
    },
  ];

  void _addProject() {
    showDialog(
      context: context,
      builder: (context) {
        final nameController = TextEditingController();
        final goalController = TextEditingController();
        final deadlineController = TextEditingController();

        return AlertDialog(
          title: const Text('Add New Project'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Project Name'),
              ),
              TextField(
                controller: goalController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Funding Goal (₹)'),
              ),
              TextField(
                controller: deadlineController,
                decoration:
                    const InputDecoration(labelText: 'Deadline (YYYY-MM-DD)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final name = nameController.text.trim();
                final goal = int.tryParse(goalController.text.trim()) ?? 0;
                final deadline = deadlineController.text.trim();

                if (name.isNotEmpty && goal > 0 && deadline.isNotEmpty) {
                  setState(() {
                    projects.add({
                      'name': name,
                      'goal': goal,
                      'currentFunding': 0,
                      'deadline': deadline,
                      'uuid': Uuid().v4(),
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
        title: const Text('Crowdfunding Projects'),
      ),
      body: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          var project = projects[index];

          return Card(
            margin: const EdgeInsets.all(10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: const Icon(Icons.monetization_on,
                  size: 50, color: Colors.green),
              title: Text(
                project['name'],
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _addProject,
        child: const Icon(Icons.add),
      ),
    );
  }
}
