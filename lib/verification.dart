import 'package:flutter/material.dart';

class VerificationScreen extends StatelessWidget {
  final TextEditingController aadhaarController = TextEditingController();
  final TextEditingController gstinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aadhaar & GSTIN Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: aadhaarController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Aadhaar Number',
                hintText: 'Enter your 12-digit Aadhaar number',
                border: OutlineInputBorder(),
              ),
              maxLength: 12,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: gstinController,
              decoration: const InputDecoration(
                labelText: 'GSTIN',
                hintText: 'Enter your GSTIN',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                String aadhaarNumber = aadhaarController.text.trim();
                String gstin = gstinController.text.trim();
                
                if (_validateAadhaar(aadhaarNumber) && _validateGstin(gstin)) {
                  // Proceed with verification logic
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Verification Successful!'),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Invalid Aadhaar or GSTIN!'),
                  ));
                }
              },
              child: const Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateAadhaar(String aadhaar) {
    // Aadhaar validation logic (basic example)
    return aadhaar.length == 12 && RegExp(r'^[0-9]{12}$').hasMatch(aadhaar);
  }

  bool _validateGstin(String gstin) {
    // GSTIN validation logic (basic example)
    return gstin.length == 15 && RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$').hasMatch(gstin);
  }
}
