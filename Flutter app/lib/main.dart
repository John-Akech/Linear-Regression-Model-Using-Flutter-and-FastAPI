import 'package:flutter/material.dart';
import 'predictor_page.dart';  // This should be correct based on your file name

void main() {
  runApp(PredictorApp());
}

class PredictorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MENTAL HEALTH PREDICTOR',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PredictorPage(),  // Correct reference to the page widget
    );
  }
}
