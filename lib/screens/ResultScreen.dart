import 'package:flutter/material.dart';
import 'dart:io';

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
              
              if (widget.edibility.toLowerCase() == 'edible')
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: CatchyButton(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CatchyButton extends StatefulWidget {
  @override
  _CatchyButtonState createState() => _CatchyButtonState();
}

class _CatchyButtonState extends State<CatchyButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orangeAccent, Colors.deepOrange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(4, 4),
                blurRadius: 10,
              ),
            ],
          ),
          child: Text(
            "Get Recipe",
            style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
