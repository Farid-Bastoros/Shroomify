import 'package:flutter/material.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart';

import 'package:shroomify/recipe/recipeGenerator.dart';
import 'package:shroomify/screens/RecipeScreen.dart';
import 'package:shroomify/screens/RecipeWaitingScreen.dart';

class ResultScreen extends StatefulWidget {
  final String mushroomName;
  final String edibility;
  final double confidenceScore;
  final String source;

  const ResultScreen({
    required this.mushroomName,
    required this.edibility,
    required this.confidenceScore,
    required this.source,
    Key? key,
  }) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  void _shareResult() {
    final String shareText = "Mushroom Identification Result:\n"
        "Name: ${widget.mushroomName}\n"
        "Edibility: ${widget.edibility}\n"
        "Confidence Score: ${(widget.confidenceScore * 100).toStringAsFixed(2)}%\n"
        "Source: ${widget.source}";
    Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Identification Result')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.green.shade200, 
              Colors.green.shade800, 
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/Tick.gif', 
                      height: 250,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.mushroomName,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Edibility: ${widget.edibility}",
                      style: TextStyle(
                        fontSize: 18,
                        color: widget.edibility.toLowerCase() == 'poisonous'
                            ? Colors.red
                            : const Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Confidence Score: ${(widget.confidenceScore * 100).toStringAsFixed(2)}%",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Source: ${widget.source}",
                      style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              
              if (widget.edibility.toLowerCase() == 'edible' || widget.edibility.toLowerCase() == 'choice')
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeWaitingScreen(mushroomName: widget.mushroomName),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text("Get Recipe", style: TextStyle(fontSize: 18)),
                  ),
                ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _shareResult,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text("Share", style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

