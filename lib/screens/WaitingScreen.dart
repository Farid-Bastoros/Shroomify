import 'package:flutter/material.dart';
import 'package:shroomify/experts/macro_expert.dart';
import 'dart:async';
import 'dart:io';
import 'ResultScreen.dart';

class WaitingScreen extends StatefulWidget {
  final File image;

  WaitingScreen({required this.image});

  @override
  _WaitingScreenState createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  bool _isProcessing = true;

  @override
  void initState() {
    super.initState();
    _startIdentificationProcess();
  }

  String _mushroomName = '';
  String _edibility = '';
  double _confidenceScore = 0.0;
  String _source = 'Mushroom.id API';

 Future<void> _startIdentificationProcess() async {
  try {
    final result = await identifyMushroomImage(widget.image);

    final isMushroom = result['result']['is_mushroom']?['binary'] ?? false;
    final suggestions = result['result']?['classification']?['suggestions'];

    if (!isMushroom) {
      print('Image is not likely a mushroom');
      throw Exception('Image is not a mushroom');
    }

    if (suggestions != null && suggestions.isNotEmpty) {
      final topResult = suggestions[0];

      setState(() {
        _mushroomName = topResult['name'] ?? 'Unknown';
        _confidenceScore = (topResult['probability'] ?? 0.0).toDouble();
        _edibility = topResult["details"]["edibility"]; // You can add a lookup later
        _isProcessing = false;
      });
    } else {
      throw Exception('No suggestions returned');
    }
  } catch (e) {
    print('Error identifying mushroom: $e');
    setState(() {
      _mushroomName = 'Identification Failed';
      _edibility = 'N/A';
      _confidenceScore = 0.0;
      _isProcessing = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Waiting for Identification')),
      body: Center(
        child: _isProcessing
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Identifying image... Please wait.'),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 50),
                  SizedBox(height: 20),
                  Text('Identification Complete!'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(
                            mushroomName: _mushroomName,
                            edibility: _edibility,
                            confidenceScore: _confidenceScore,
                            source: _source,
                          ),
                        ),
                      );
                    },
                    child: Text('View Result'),
                  ),
                ],
              ),
      ),
    );
  }
}
