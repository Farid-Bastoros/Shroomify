import 'package:flutter/material.dart';
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

  void _submitDescription() async {
    if (_description.isEmpty) return;

    try {
      final result = await analyzeMushroomDescription(_description);
      print('LLM Response:\n$result'); // Log to console
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('LLM response printed to console!')),
      );
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to analyze description')),
      );
    } finally {
    }
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
            
            Center(
              child: ElevatedButton(
                onPressed: _submitDescription,
                child: Text('Submit Description'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

