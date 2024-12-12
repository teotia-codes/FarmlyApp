import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommunityJsonPrinterPage extends StatefulWidget {
  const CommunityJsonPrinterPage({Key? key}) : super(key: key);

  @override
  _CommunityJsonPrinterPageState createState() =>
      _CommunityJsonPrinterPageState();
}

class _CommunityJsonPrinterPageState extends State<CommunityJsonPrinterPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _fetchAndPrintCommunitiesJson();
  }

  Future<void> _fetchAndPrintCommunitiesJson() async {
    try {
      // Fetch the collection of communities
      final snapshot = await _firestore.collection('communities').get();

      // Map Firestore documents into a structured JSON
      final communitiesMap = <String, dynamic>{};
      for (var doc in snapshot.docs) {
        communitiesMap[doc.id] = doc.data();
      }

      // Convert the map to a JSON string
      final jsonString = jsonEncode({'communities': communitiesMap});

      // Print the JSON string to the console
      print(jsonString);
    } catch (e) {
      print('Error fetching communities: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community JSON Printer'),
      ),
      body: const Center(
        child: Text(
          'Check your console for the JSON data!',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
