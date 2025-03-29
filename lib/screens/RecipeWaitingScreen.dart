import 'package:flutter/material.dart';
import 'package:shroomify/recipe/recipeGenerator.dart';
import 'package:shroomify/screens/RecipeScreen.dart';

class RecipeWaitingScreen extends StatefulWidget {
  final String mushroomName;

  RecipeWaitingScreen({required this.mushroomName});

  @override
  _RecipeWaitingScreenState createState() => _RecipeWaitingScreenState();
}

class _RecipeWaitingScreenState extends State<RecipeWaitingScreen> {
  bool _isProcessing = true;
  String _recipe = '';

  @override
  void initState() {
    super.initState();
    _startRecipeGeneration();
  }

  Future<void> _startRecipeGeneration() async {
    try {
      final result = await generateRecipe(widget.mushroomName);
      setState(() {
        _recipe = result;
        _isProcessing = false;
      });

      // Navigate to the final RecipeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RecipeScreen(
            mushroomName: widget.mushroomName,
            recipe: _recipe,
          ),
        ),
      );
    } catch (e) {
      print('Error generating recipe: $e');
      setState(() {
        _isProcessing = false;
        _recipe = 'Failed to generate recipe. Please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Generating Recipe')),
      body: Center(
        child: _isProcessing
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Generating recipe... Please wait.'),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.error_outline, color: Colors.red, size: 50),
                  SizedBox(height: 20),
                  Text('Something went wrong.'),
                ],
              ),
      ),
    );
  }
}
