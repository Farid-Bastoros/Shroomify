import 'package:flutter/material.dart';
import 'package:shroomify/experts/macro_expert.dart'; 
import 'dart:async';
import 'dart:io';
import 'ResultScreen.dart';
import 'package:shroomify/experts/text_expert.dart';

class WaitingScreen extends StatefulWidget {
  final File? image;
  final String description;

  WaitingScreen({required this.image, required this.description});

  @override
  _WaitingScreenState createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  bool _isProcessing = true;

  String _mushroomName = '';
  String _edibility = '';
  double _confidenceScore = 0.0;
  String _source = 'Mushroom.id API';

  @override
  void initState() {
    super.initState();
    _startIdentificationProcess();
  }

  Future<void> _startIdentificationProcess() async {
  try {
    if (widget.image != null) {
      // Image-based identification
      final result = await identifyMushroomImage(widget.image!);
      print('Image identification result: $result');

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
          _confidenceScore = (topResult['probability'] * 100 ?? 0.0).toDouble();
          _edibility = topResult["details"]["edibility"] ?? 'Unknown';
          _source = 'Mushroom.id API';
        });
      } else {
        throw Exception('No suggestions returned');
      }
    } else if (widget.description.isNotEmpty) {
      final result = await analyzeMushroomDescription(widget.description);
      print('LLM identification result: $result');

      setState(() {
        _mushroomName = result['speciesName'] ?? 'Unknown';
        _confidenceScore = result['confidenceScore'] ?? 0.0;
        _edibility = result['edibility'] ?? 'Unknown';
        _source = 'LLM Response';
      });
    } else {
      throw Exception('No image or description provided');
    }
  } catch (e) {
    print('Error identifying mushroom: $e');
    setState(() {
      _mushroomName = 'Identification Failed';
      _edibility = 'N/A';
      _confidenceScore = 0.0;
    });
  } finally {
    setState(() {
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
                  Text('Identifying... Please wait.'),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 50),
                  SizedBox(height: 20),
                  Text('Identification Complete!'),
                  SizedBox(height: 20),
                  if (widget.description.isNotEmpty) ...[
                    // Text('Description: ${widget.description}',
                    //     style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
                    // SizedBox(height: 10),
                  ],
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


