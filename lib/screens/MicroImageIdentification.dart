import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:animations/animations.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '/screens/WaitingScreen.dart';
import 'package:shroomify/experts/text_expert.dart'; 

class Microimageidentification extends StatefulWidget {
  @override
  _MicroimageidentificationState createState() =>
      _MicroimageidentificationState();
}

class _MicroimageidentificationState extends State<Microimageidentification> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void _submitData(BuildContext context) async {
  String description = _descriptionController.text.trim();
  
  // If there's a description and no image, we use LLM for analysis
  if (description.isNotEmpty && _image == null) {
    try {
      final result = await analyzeMushroomDescription(description);
      print('LLM Response:\n$result'); 

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('LLM response printed to console!')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WaitingScreen(
            image: null, 
            description: description,
          ),
        ),
      );
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to analyze description')),
      );
    }
  }
  // If both an image and description are provided, use the image only for analysis
  else if (_image != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WaitingScreen(
          image: _image, 
          description: description,
        ),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please select an image or enter a description.')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Micro Image Identification',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 10,
        shadowColor: Colors.black26,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(  
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeScaleTransition(animation: animation, child: child);
                },
                child: _image == null
                    ? Icon(LucideIcons.imageOff, size: 100, color: Colors.white60)
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(_image!, width: 250, height: 250, fit: BoxFit.cover),
                      ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Enter a description...',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepPurple,
                  elevation: 5,
                ),
                onPressed: () => _pickImage(ImageSource.gallery),
                icon: Icon(LucideIcons.image),
                label: Text('Pick from Gallery', style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 15),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepPurple,
                  elevation: 5,
                ),
                onPressed: () => _pickImage(ImageSource.camera),
                icon: Icon(LucideIcons.camera),
                label: Text('Take a Photo', style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.greenAccent,
                  foregroundColor: Colors.black,
                  elevation: 5,
                ),
                onPressed: () => _submitData(context),
                icon: Icon(LucideIcons.upload),
                label: Text('Submit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
