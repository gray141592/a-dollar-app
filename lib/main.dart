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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => SafeArea(child: child!),
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
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
