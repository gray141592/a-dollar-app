import 'package:a_dollar_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './routes.dart';
import 'package:a_dollar_app/controllers/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseController firebaseController = FirebaseController();
  NetworkController networkController = NetworkController();
  SuccessController successController = SuccessController();
  PurchaseController purchaseController = PurchaseController();

  await purchaseController.initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<NetworkController>(
          create: (_) => networkController,
        ),
        ChangeNotifierProvider<SuccessController>(
          create: (_) => successController,
        ),
        ChangeNotifierProvider<FirebaseController>(
          create: (_) => firebaseController,
        ),
        ChangeNotifierProvider<PurchaseController>(
          create: (_) => purchaseController,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    // cancel your subscription when the class is removed
    PurchaseController purchaseController =
        Provider.of<PurchaseController>(super.context, listen: false);
    FirebaseController firebaseController =
        Provider.of<FirebaseController>(super.context, listen: false);
    purchaseController.onDispose();
    firebaseController.stopListening();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => SafeArea(child: child!),
      theme: ThemeData(
        fontFamily: 'Brawler',
        textTheme: TextTheme(
          bodySmall: TextStyle(
            color: DollarTheme.pinkText,
          ),
          bodyMedium: TextStyle(
            color: DollarTheme.orangeText,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
          bodyLarge: TextStyle(
            color: DollarTheme.orangeText,
            fontWeight: FontWeight.w700,
            fontSize: 27,
          ),
        ),
        backgroundColor: DollarTheme.background,
      ),
      home: Routes.homeRoute,
      routes: Routes.routes,
    );
  }
}
