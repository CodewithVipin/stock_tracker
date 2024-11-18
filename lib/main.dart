import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stock_records/screens/stock.dart';
import 'package:stock_records/screens/stock_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(StockAdapter());
  await Hive.openBox<Stock>('stocks');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stock Tracker',
      theme: ThemeData.dark().copyWith(
        // Primary color set to a coffee brown shade
        primaryColor: const Color(0xFF3E2723), // Dark brown
        scaffoldBackgroundColor:
            const Color(0xFF3E2723), // Coffee brown background
        textTheme: TextTheme(
          bodyMedium: TextStyle(
              color: Colors.brown[50]), // Light text on dark background
        ),
        // Card color set to a darker shade for the coffee effect
        cardColor: const Color(0xFF4E342E), // Darker coffee brown
        // Accent color for buttons and other elements
        colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: const Color(0xFF8D6E63)), // Light brown for accents
        // Button styles for a warm theme
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF8D6E63), // Light brown button color
          textTheme: ButtonTextTheme.primary, // Button text color (light)
        ),
        // AppBar customization
        appBarTheme: AppBarTheme(
          backgroundColor:
              const Color(0xFF3E2723), // Matching the dark brown for the AppBar
          elevation: 0,
          titleTextStyle:
              TextStyle(color: Colors.brown[50]), // Light title text
        ),
      ),
      home: const StockScreen(),
    );
  }
}
