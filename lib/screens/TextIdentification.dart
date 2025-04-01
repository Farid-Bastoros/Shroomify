import 'package:flutter/material.dart';
import 'package:shroomify/experts/decision_forum.dart';
import 'package:shroomify/experts/text_expert.dart';
import '/screens/WaitingScreen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TextIdentification extends StatefulWidget {
  @override
  _TextIdentificationState createState() => _TextIdentificationState();
}

class _TextIdentificationState extends State<TextIdentification> {
  final TextEditingController _controller = TextEditingController();
  String _description = '';

  double capDiameter = 0.0;

  String color = '';
  String surface = '';
  String gillThickness = '';
  double stemLength = 0.0;
  String location = '';

  _TextIdentificationState(){
    capDiameter = DecisionForum.instance.textExpert!.capDiameter;
    surface = DecisionForum.instance.textExpert!.surface;
    gillThickness = DecisionForum.instance.textExpert!.gillThickness;
    stemLength = DecisionForum.instance.textExpert!.stemLength;
    color = DecisionForum.instance.textExpert!.color;
    location = DecisionForum.instance.textExpert!.location;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Identification'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Text(
              'Enter the Description',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 20),
            
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Describe the mushroom...',
                labelText: 'Mushroom Description',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                ),
              ),
              onChanged: (text) {
                setState(() {
                  _description = text;
                });
              },
            ),
            SizedBox(height: 20),
            

          ],
        ),
      ),
    );
  }
}

