import 'package:uuid/uuid.dart';

class CommunityFetch {
  final String uid;
  final String name;
  final String location;
  final int members;
  final int stockPercent;
  final String description;
  final List<String> tags;

  // Constructor
  CommunityFetch({
    required this.uid,
    required this.name,
    required this.location,
    required this.members,
    required this.stockPercent,
    required this.description,
    required this.tags,
  });

  // Factory method to create an instance from a Firebase map
  factory CommunityFetch.fromMap(Map<String, dynamic> map) {
    return CommunityFetch(
      uid: map['uid'] ?? Uuid().v4(),
      name: map['name'] ?? '',
      location: map['location'] ?? '',
      members: map['members'] ?? 0,
      stockPercent: map['stockPercent'] ?? 0,
      description: map['description'] ?? '',
      tags: List<String>.from(map['tags'] ?? []),
    );
  }

  // Convert the instance to a map for storage in Firebase
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'location': location,
      'members': members,
      'stockPercent': stockPercent,
      'description': description,
      'tags': tags,
    };
  }
}
