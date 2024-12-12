import 'package:app/farmer_direc/community/view/utils_intermediate.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final List<Map<String, dynamic>> _initialCommunities = [
    {
      'uid': Uuid().v4(),
      'name': 'AgroConnect',
      'location': 'Texas, USA',
      'members': 1200,
      'stockPercent': 75,
      'description':
          'Connecting farmers across Texas, sharing resources and knowledge.',
      'tags': ['Organic', 'Sustainable', 'Livestock']
    },
    {
      'uid': Uuid().v4(),
      'name': 'Harvest Helpers',
      'location': 'Ontario, Canada',
      'members': 950,
      'stockPercent': 60,
      'description':
          'Supporting local farmers with innovative agricultural solutions.',
      'tags': ['Crop Sharing', 'Technology', 'Innovation']
    },
  ];

  // List to store pending community creation requests
  final List<Map<String, dynamic>> _pendingCommunities = [];

  List<Map<String, dynamic>> communities = [];
  List<Map<String, dynamic>> farmerIds = [
    {'id': Uuid().v4(), 'name': 'John Doe', 'location': 'Texas'},
    {'id': Uuid().v4(), 'name': 'Jane Smith', 'location': 'California'},
    {'id': Uuid().v4(), 'name': 'Mike Johnson', 'location': 'Iowa'},
    {'id': Uuid().v4(), 'name': 'Sarah Williams', 'location': 'Nebraska'},
    {'id': Uuid().v4(), 'name': 'David Brown', 'location': 'Kansas'},
    {'id': Uuid().v4(), 'name': 'Emily Davis', 'location': 'Oklahoma'},
    {'id': Uuid().v4(), 'name': 'Tom Wilson', 'location': 'Missouri'},
    {'id': Uuid().v4(), 'name': 'Lisa Garcia', 'location': 'Colorado'},
    {'id': Uuid().v4(), 'name': 'Robert Taylor', 'location': 'New Mexico'},
  ];

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _communityNameController =
      TextEditingController();
  final TextEditingController _communityLocationController =
      TextEditingController();
  final TextEditingController _communityDescriptionController =
      TextEditingController();

  List<Map<String, dynamic>> _selectedFarmers = [];

  @override
  void initState() {
    super.initState();
    communities = List.from(_initialCommunities);
  }

  void _createCommunity() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.9,
              maxChildSize: 0.95,
              minChildSize: 0.6,
              builder: (_, controller) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: ListView(
                    controller: controller,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Create New Community',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[900],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20),

                            // Community Name Input
                            TextField(
                              controller: _communityNameController,
                              decoration: InputDecoration(
                                labelText: 'Community Name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),

                            // Community Location Input
                            TextField(
                              controller: _communityLocationController,
                              decoration: InputDecoration(
                                labelText: 'Community Location',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),

                            // Community Description Input
                            TextField(
                              controller: _communityDescriptionController,
                              maxLines: 3,
                              decoration: InputDecoration(
                                labelText: 'Community Description',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),

                            // Select Farmers Section
                            Text(
                              'Select Initial Farmers (Minimum 9)',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[800],
                              ),
                            ),
                            SizedBox(height: 10),

                            // Farmers Selection List
                            Container(
                              height: 300,
                              child: ListView.builder(
                                itemCount: farmerIds.length,
                                itemBuilder: (context, index) {
                                  final farmer = farmerIds[index];
                                  final isSelected =
                                      _selectedFarmers.contains(farmer);

                                  return CheckboxListTile(
                                    title: Text(farmer['name']),
                                    subtitle: Text(farmer['location']),
                                    value: isSelected,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        if (value == true) {
                                          _selectedFarmers.add(farmer);
                                        } else {
                                          _selectedFarmers.remove(farmer);
                                        }
                                      });
                                    },
                                  );
                                },
                              ),
                            ),

                            // Submit Button
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _selectedFarmers.length >= 9
                                  ? _submitCommunityRequest
                                  : null,
                              style: ElevatedButton.styleFrom(
                                iconColor: Colors.green[800],
                                padding: EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Submit Community Request',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void _submitCommunityRequest() {
    if (_communityNameController.text.isEmpty ||
        _communityLocationController.text.isEmpty ||
        _communityDescriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final newCommunityRequest = {
      'uid': Uuid().v4(),
      'name': _communityNameController.text,
      'location': _communityLocationController.text,
      'description': _communityDescriptionController.text,
      'members': _selectedFarmers.length,
      'stockPercent': 0,
      'tags': [],
      'initialFarmers': _selectedFarmers,
      'status': 'Pending Approval'
    };

    setState(() {
      _pendingCommunities.add(newCommunityRequest);
    });

    // Reset controllers and selected farmers
    _communityNameController.clear();
    _communityLocationController.clear();
    _communityDescriptionController.clear();
    _selectedFarmers.clear();

    Navigator.pop(context);

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Community request submitted for approval'),
        backgroundColor: Colors.green[800],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Farmer Communities',
          style: TextStyle(
            color: Colors.green[900],
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.pending, color: Colors.green[900]),
            onPressed: () {
              // Show pending communities
              _showPendingCommunities();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: communities.length,
        itemBuilder: (context, index) {
          final community = communities[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => UtilsScreenCommunity())),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        community['name'],
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[900],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        community['location'],
                        style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        community['description'],
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${community['members']} Members',
                            style: TextStyle(
                              color: Colors.green[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Join community logic
                            },
                            style: ElevatedButton.styleFrom(
                              iconColor: Colors.green[800],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text('Join'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createCommunity,
        backgroundColor: Colors.green[800],
        child: Icon(Icons.add),
      ),
    );
  }

  void _showPendingCommunities() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pending Community Requests'),
          content: _pendingCommunities.isEmpty
              ? Text('No pending community requests.')
              : SingleChildScrollView(
                  child: Column(
                    children: _pendingCommunities.map((community) {
                      return ListTile(
                        title: Text(community['name']),
                        subtitle: Text(community['location']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.check, color: Colors.green),
                              onPressed: () {
                                // Approve community
                                _approveCommunity(community);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: () {
                                // Reject community
                                _rejectCommunity(community);
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _approveCommunity(Map<String, dynamic> community) {
    setState(() {
      // Remove from pending list
      _pendingCommunities.remove(community);

      // Add to active communities
      communities.add({
        ...community,
        'status': 'Active',
        'tags': ['New Community'],
      });
    });

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Community "${community['name']}" approved'),
        backgroundColor: Colors.green[800],
      ),
    );
  }

  void _rejectCommunity(Map<String, dynamic> community) {
    setState(() {
      // Remove from pending list
      _pendingCommunities.remove(community);
    });

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Community "${community['name']}" rejected'),
        backgroundColor: Colors.red[800],
      ),
    );
  }
}
