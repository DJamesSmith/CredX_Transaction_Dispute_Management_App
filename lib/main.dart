import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transaction_dispute/config/app_color.dart';
import 'package:transaction_dispute/controllers/transaction_controller.dart';
import 'package:transaction_dispute/screens/home_screen.dart';

void main() {
  Get.put(TransactionController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorFile.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
