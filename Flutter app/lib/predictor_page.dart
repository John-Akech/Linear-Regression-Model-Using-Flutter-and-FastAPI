import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PredictorPage extends StatefulWidget {
  @override
  _PredictorPageState createState() => _PredictorPageState();
}

class _PredictorPageState extends State<PredictorPage> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _stressLevelController = TextEditingController();
  final TextEditingController _depressionScoreController = TextEditingController();
  final TextEditingController _anxietyScoreController = TextEditingController();
  final TextEditingController _physicalActivityController = TextEditingController();

  String _predictionResult = '';

  Future<void> _predict() async {
    final url = Uri.parse('http://10.0.2.2:8000/predict'); // Emulator URL
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "Age": int.parse(_ageController.text),
          "Stress_Level": double.parse(_stressLevelController.text),
          "Depression_Score": double.parse(_depressionScoreController.text),
          "Anxiety_Score": double.parse(_anxietyScoreController.text),
          "Physical_Activity": int.parse(_physicalActivityController.text),
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _predictionResult = "Predicted Sleep Quality: ${data['message']}";
        });
      } else {
        setState(() {
          _predictionResult = "Error: ${response.body}";
        });
      }
    } catch (e) {
      setState(() {
        _predictionResult = "An error occurred: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mental Health Predictor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _stressLevelController,
              decoration: InputDecoration(labelText: 'Stress Level (0-10)'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: _depressionScoreController,
              decoration: InputDecoration(labelText: 'Depression Score (0-10)'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: _anxietyScoreController,
              decoration: InputDecoration(labelText: 'Anxiety Score (0-10)'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: _physicalActivityController,
              decoration: InputDecoration(labelText: 'Physical Activity (0=Low, 1=Moderate, 2=High)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _predict,
              child: Text('Predict Sleep Quality'),
            ),
            SizedBox(height: 20),
            Text(_predictionResult),
          ],
        ),
      ),
    );
  }
}