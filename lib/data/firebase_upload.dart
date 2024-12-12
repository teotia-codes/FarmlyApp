// community.dart
import 'package:app/data/firebase_dummy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:convert';

import 'package:flutter/material.dart';

class Community {
  String? id;
  String name;
  int memberCount;
  List<String> members;
  String location;
  List<String> tags;
  List<Crowdfunding> crowdfunding;
  List<MonthlyDeliverable> monthlyDeliverables;
  List<Selling> selling;
  List<Sharing> sharing;
  List<Transport> transport;

  Community({
    this.id,
    required this.name,
    required this.memberCount,
    required this.members,
    required this.location,
    required this.tags,
    required this.crowdfunding,
    required this.monthlyDeliverables,
    required this.selling,
    required this.sharing,
    required this.transport,
  });

  // Convert JSON to Community object
  factory Community.fromJson(Map<String, dynamic> json, String communityId) {
    return Community(
      id: communityId,
      name: json['name'] ?? '',
      memberCount: json['memberCount'] ?? 0,
      members: List<String>.from(json['members'] ?? []),
      location: json['location'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      crowdfunding: (json['crowdfunding'] as List?)
              ?.map((e) => Crowdfunding.fromJson(e))
              ?.toList() ??
          [],
      monthlyDeliverables: (json['monthly_deliverables'] as List?)
              ?.map((e) => MonthlyDeliverable.fromJson(e))
              ?.toList() ??
          [],
      selling: (json['selling'] as List?)
              ?.map((e) => Selling.fromJson(e))
              ?.toList() ??
          [],
      sharing: (json['sharing'] as List?)
              ?.map((e) => Sharing.fromJson(e))
              ?.toList() ??
          [],
      transport: (json['transport'] as List?)
              ?.map((e) => Transport.fromJson(e))
              ?.toList() ??
          [],
    );
  }

  // Convert Community to a map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'memberCount': memberCount,
      'members': members,
      'location': location,
      'tags': tags,
      'crowdfunding': crowdfunding.map((e) => e.toFirestore()).toList(),
      'monthly_deliverables':
          monthlyDeliverables.map((e) => e.toFirestore()).toList(),
      'selling': selling.map((e) => e.toFirestore()).toList(),
      'sharing': sharing.map((e) => e.toFirestore()).toList(),
      'transport': transport.map((e) => e.toFirestore()).toList(),
    };
  }
}

class Crowdfunding {
  String name;
  int goal;
  int currentFunding;
  DateTime deadline;

  Crowdfunding({
    required this.name,
    required this.goal,
    required this.currentFunding,
    required this.deadline,
  });

  factory Crowdfunding.fromJson(Map<String, dynamic> json) {
    return Crowdfunding(
      name: json['name'] ?? '',
      goal: json['goal'] ?? 0,
      currentFunding: json['currentFunding'] ?? 0,
      deadline:
          DateTime.parse(json['deadline'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'goal': goal,
      'currentFunding': currentFunding,
      'deadline': deadline.toIso8601String(),
    };
  }
}

class MonthlyDeliverable {
  String buyer;
  List<String> products;
  String quantity;
  DateTime deliveryDate;
  String uuid;

  MonthlyDeliverable({
    required this.buyer,
    required this.products,
    required this.quantity,
    required this.deliveryDate,
    required this.uuid,
  });

  factory MonthlyDeliverable.fromJson(Map<String, dynamic> json) {
    return MonthlyDeliverable(
      buyer: json['buyer'] ?? '',
      products: List<String>.from(json['products'] ?? []),
      quantity: json['quantity'] ?? '',
      deliveryDate: DateTime.parse(
          json['deliveryDate'] ?? DateTime.now().toIso8601String()),
      uuid: json['uuid'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'buyer': buyer,
      'products': products,
      'quantity': quantity,
      'deliveryDate': deliveryDate.toIso8601String(),
      'uuid': uuid,
    };
  }
}

class Selling {
  String name;
  int quantity;
  int price;
  String uuid;

  Selling({
    required this.name,
    required this.quantity,
    required this.price,
    required this.uuid,
  });

  factory Selling.fromJson(Map<String, dynamic> json) {
    return Selling(
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: json['price'] ?? 0,
      uuid: json['uuid'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
      'uuid': uuid,
    };
  }
}

class Sharing {
  String toolName;
  String availability;
  String owner;
  String uuid;

  Sharing({
    required this.toolName,
    required this.availability,
    required this.owner,
    required this.uuid,
  });

  factory Sharing.fromJson(Map<String, dynamic> json) {
    return Sharing(
      toolName: json['toolName'] ?? '',
      availability: json['availability'] ?? '',
      owner: json['owner'] ?? '',
      uuid: json['uuid'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'toolName': toolName,
      'availability': availability,
      'owner': owner,
      'uuid': uuid,
    };
  }
}

class Transport {
  String vehicle;
  String availability;
  int costPerTrip;
  String uuid;

  Transport({
    required this.vehicle,
    required this.availability,
    required this.costPerTrip,
    required this.uuid,
  });

  factory Transport.fromJson(Map<String, dynamic> json) {
    return Transport(
      vehicle: json['vehicle'] ?? '',
      availability: json['availability'] ?? '',
      costPerTrip: json['cost_per_trip'] ?? 0,
      uuid: json['uuid'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'vehicle': vehicle,
      'availability': availability,
      'cost_per_trip': costPerTrip,
      'uuid': uuid,
    };
  }
}

// firestore_service.dart

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Upload entire communities collection from JSON
  Future<void> uploadCommunitiesFromJson(String jsonString) async {
    try {
      // Parse the JSON string
      Map<String, dynamic> data = json.decode(jsonString);

      // Get the communities collection
      Map<String, dynamic> communities = data['communities'];

      // Batch write to Firestore
      WriteBatch batch = _firestore.batch();

      // Iterate through each community
      communities.forEach((communityId, communityData) {
        // Create Community object
        Community community = Community.fromJson(communityData, communityId);

        // Reference to the document
        DocumentReference docRef =
            _firestore.collection('communities').doc(communityId);

        // Set the document data in the batch
        batch.set(docRef, community.toFirestore());
      });

      // Commit the batch
      await batch.commit();

      print('Successfully uploaded communities to Firestore');
    } catch (e) {
      print('Error uploading communities: $e');
    }
  }

  // Optional: Method to get a single community
  Future<Community?> getCommunity(String communityId) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('communities').doc(communityId).get();

      if (snapshot.exists) {
        return Community.fromJson(
            snapshot.data() as Map<String, dynamic>, snapshot.id);
      }
      return null;
    } catch (e) {
      print('Error fetching community: $e');
      return null;
    }
  }
}

class FirebaseUpload extends StatelessWidget {
  const FirebaseUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              final FirestoreService firestoreService = FirestoreService();
              firestoreService
                  .uploadCommunitiesFromJson(jsonFirebase.toString());
            },
            child: Text("Upload")),
      ),
    );
  }
}
