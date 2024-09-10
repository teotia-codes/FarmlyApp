import 'package:app/farmer_direc/orders/view/order_view.dart';
import 'package:app/farmer_direc/orders/viewmodel/orderViewModel.dart';
import 'package:app/firebase_options.dart';
import 'package:app/provider/farmer_retrieve.dart';
import 'package:app/retailer_direc/pages/home_page.dart';
import 'package:app/retailer_direc/pages/order_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:app/farmer_direc/inventory/model/farmer_inventory_model.dart';
import 'package:app/farmer_direc/inventory/viewmodel/inventory_provider.dart';
import 'package:app/farmerinfo.dart';
import 'package:app/onboarding.dart';
import 'package:app/provider/farmer/farmer_provider.dart';
import 'package:app/provider/farmer_upload.dart';
import 'package:app/razorpay/razorpay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(    options: DefaultFirebaseOptions.currentPlatform,
); // Initialize Firebase

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => InventoryProvider(exampleInventoryItems),
          ),
          ChangeNotifierProvider(
            create: (_) => FarmerProvider(),
          ),
          // Add other providers here
          ChangeNotifierProvider(
            create: (_) => OrderProvider(),
          ),
        ],
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
