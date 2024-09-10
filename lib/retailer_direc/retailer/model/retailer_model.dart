class RetailerAccount {
  String retailerId;
  String name;
  String email;
  String gstin;
  String phoneNumber;
  String address;

  RetailerAccount({
    required this.retailerId,
    required this.name,
    required this.email,
    required this.gstin,
    required this.phoneNumber,
    required this.address,
  });

  // Convert RetailerAccount to Firebase document
  Map<String, dynamic> toMap() {
    return {
      'retailerId': retailerId,
      'name': name,
      'email': email,
      'gstin': gstin,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }

  // Create RetailerAccount from Firebase document
  factory RetailerAccount.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return RetailerAccount(
      retailerId: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      gstin: data['gstin'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      address: data['address'] ?? '',
    );
  }
}
