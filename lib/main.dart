import 'package:flutter/material.dart';
import 'package:qr_scanner/pages/qr_scanner_page.dart';
// import 'package:qr_scanner/pages/generator_page.dart';
// import 'package:qr_scanner/pages/scanner_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QrScannerPage(),
    );
  }
}

