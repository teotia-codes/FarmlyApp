import 'package:app/farmer_direc/dashboard/model/farmer_model.dart';
import 'package:app/provider/farmer/farmer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FarmersListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmers List'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('farmers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No farmers available.'));
          }

          List<FarmerModel> farmers = snapshot.data!.docs.map((doc) {
            return FarmerModel.fromFirestore(doc.data() as Map<String, dynamic>);
          }).toList();

          return ListView.builder(
            itemCount: farmers.length,
            itemBuilder: (context, index) {
              return FarmerTile(farmer: farmers[index]);
            },
          );
        },
      ),
    );
  }
}

class FarmerTile extends StatelessWidget {
  final FarmerModel farmer;

  FarmerTile({required this.farmer});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(farmer.name[0]),
      ),
      title: Text(farmer.name),
      subtitle: Text('ID: ${farmer.id}\nAddress: ${farmer.add}\nCIBIL: ${farmer.credit.cibilScore}'),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {
        // Handle navigation or actions when a farmer is tapped
      },
    );
  }
}
