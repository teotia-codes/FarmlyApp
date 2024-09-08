import 'package:app/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';


class FarmerInfo extends StatefulWidget {
  @override
  State<FarmerInfo> createState() => _FarmerInfo();
}

class _FarmerInfo extends State<FarmerInfo> {
  final TextEditingController aadhaarController = TextEditingController();

  final TextEditingController gstinController = TextEditingController();

   final TextEditingController bussaddr = TextEditingController();

  String? selectedFilePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your details' , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              GestureDetector(
              onTap: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles();
                
                if (result != null) {
                  setState(() {
                    selectedFilePath = result.files.single.path;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Selected file: $selectedFilePath'),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('No file selected'),
                  ));
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 70,right: 70),
                child: Container(
                  width: 10,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset('assets/file.svg')
                ),
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: aadhaarController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Aadhaar Number',
                hintText: 'Enter your 12-digit Aadhaar number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
              ),
              maxLength: 12,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: gstinController,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
              ),
            ),
            const SizedBox(height: 30),
             TextField(
              controller: bussaddr,
              decoration: const InputDecoration(
                labelText: 'Address',
                hintText: 'Enter your address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
              ),
            ),            
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 200, right: 200),
              child: CustomOutlinedButton(
                onTap: () {
                  String aadhaarNumber = aadhaarController.text.trim();
                  String gstin = gstinController.text.trim();
              
                  if (_validateAadhaar(aadhaarNumber)) {
                    // Proceed with verification logic
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Verification Successful!'),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Invalid Aadhaar, GSTIN, or no file selected!'),
                    ));
                  }
                },
                text: 'Verify',
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateAadhaar(String aadhaar) {
    return aadhaar.length == 12 && RegExp(r'^[0-9]{12}$').hasMatch(aadhaar);
  }

  bool _validateGstin(String gstin) {
    return gstin.length == 15 &&
        RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$')
            .hasMatch(gstin);
  }
}
