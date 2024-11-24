import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PredictorPage extends StatefulWidget {
  @override
  _PredictorPageState createState() => _PredictorPageState();
}

class _PredictorPageState extends State<PredictorPage> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _anxietyScoreController = TextEditingController();
  final TextEditingController _depressionScoreController = TextEditingController();
  final TextEditingController _physicalActivityController = TextEditingController();
  final TextEditingController _stressLevelController = TextEditingController();

  String _predictionResult = '';
  final _formKey = GlobalKey<FormState>();

  Future<void> _predict() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final url = Uri.parse('https://linear-regression-model-using-flutter.onrender.com/predict'); // Replace with your API URL in production
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "Age": int.parse(_ageController.text),
          "Anxiety_Score": double.parse(_anxietyScoreController.text), // Correct order
          "Depression_Score": double.parse(_depressionScoreController.text),
          "Physical_Activity": int.parse(_physicalActivityController.text),
          "Stress_Level": double.parse(_stressLevelController.text), // Correct order
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Reordered the fields to match the desired order
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _anxietyScoreController,
                decoration: InputDecoration(labelText: 'Anxiety Score (0-10)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an anxiety score';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _depressionScoreController,
                decoration: InputDecoration(labelText: 'Depression Score (0-10)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a depression score';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _physicalActivityController,
                decoration: InputDecoration(labelText: 'Physical Activity (0=Low, 1=Moderate, 2=High)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a physical activity level';
                  }
                  if (int.tryParse(value) == null || int.parse(value) < 0 || int.parse(value) > 2) {
                    return 'Please enter a valid number between 0 and 2';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stressLevelController,
                decoration: InputDecoration(labelText: 'Stress Level (0-10)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a stress level';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
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
      ),
    );
  }
}
