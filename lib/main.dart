import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nike_sneakers/models/cart.dart';
import 'package:nike_sneakers/pages/intro_page.dart';
import 'package:nike_sneakers/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize notifications
  await NotificationService.initialize();
  await NotificationService.requestPermissions();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Cart(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IntroPage(),
      ),
    );
  }
}
