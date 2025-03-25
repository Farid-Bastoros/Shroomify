import 'package:flutter/material.dart';
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

  Future<void> _startIdentificationProcess() async {
    await Future.delayed(Duration(seconds: 5)); 
    setState(() {
      _isProcessing = false;
    });
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
                            //image: File('path_to_image'),
                            mushroomName: 'Amanita Muscaria',
                            edibility: 'Poisonous',
                            confidenceScore: 0.87,
                            source: 'Plant.id API',
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
