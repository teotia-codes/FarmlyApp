import 'package:app/farmer_direc/commodity/view/commodity_view.dart';
import 'package:app/farmer_direc/community/view/utils_intermediate.dart';
import 'package:app/farmer_direc/dashboard/view/farmer_dashboard.dart';
import 'package:app/farmer_direc/navbar/navbar.dart';
import 'package:app/farmer_direc/orders/view/order_view.dart';
import 'package:app/farmer_direc/orders/viewmodel/orderViewModel.dart';
import 'package:app/farmer_direc/profile/view/farmer_profile_view.dart';
import 'package:app/firebase_options.dart';
import 'package:app/local.dart';
import 'package:app/ml/view/credit_view.dart';
import 'package:app/ml/view/demand_forecast_view.dart';
import 'package:app/ml/view/disease_detection.dart';
import 'package:app/provider/farmer_retrieve.dart';
import 'package:app/retailer_direc/models/ROrderViewModel.dart';
import 'package:app/retailer_direc/pages/explore_page.dart';
import 'package:app/retailer_direc/pages/home_page.dart';
import 'package:app/retailer_direc/pages/order_page.dart';
import 'package:app/retailer_direc/retailer/model/retailer_provider.dart';
import 'package:app/retailer_direc/retailer/model/retailer_upload.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:app/farmer_direc/inventory/model/farmer_inventory_model.dart';
import 'package:app/farmer_direc/inventory/viewmodel/inventory_provider.dart';
import 'package:app/farmerinfo.dart';
import 'package:app/onboarding.dart';
import 'package:app/provider/farmer/farmer_provider.dart';
import 'package:app/provider/farmer_upload.dart';
import 'package:app/razorpay/razorpay.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
          ChangeNotifierProvider(
            create: (_) => RetailerProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ROrderProvider(),
          ),
        ],
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // localizationsDelegates: [
      //   AppLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('en'), // English
      //   Locale('hi'), // Hindi
      //   Locale('te'), // Telugu
      // ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      home:  UtilsScreenCommunity(),


    );
  }
}
