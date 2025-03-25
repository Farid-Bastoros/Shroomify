import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '/screens/WaitingScreen.dart';

class Microimageidentification extends StatefulWidget {
  @override
  _MicroimageidentificationState createState() =>
      _MicroimageidentificationState();
}

class _MicroimageidentificationState extends State<Microimageidentification> {
  File? _image;

  
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  
  void _submitImage(BuildContext context) {
    
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WaitingScreen(image: _image!)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Micro Image Identification'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 19, 118, 74), 
              Color.fromARGB(255, 219, 37, 161), 
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image == null
                  ? Text('No image selected.')
                  : Image.file(_image!),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick an Image'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _submitImage(context),
                child: Text('Submit Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
