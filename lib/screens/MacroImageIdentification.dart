import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shroomify/experts/decision_forum.dart';

class Macroimageidentification extends StatefulWidget {
  @override
  _MacroimageidentificationState createState() =>
      _MacroimageidentificationState();
}

class _MacroimageidentificationState extends State<Macroimageidentification> {
  File? _image;

  _MacroimageidentificationState(){
    File? imageMacro = DecisionForum.instance.macroImageExpert?.getImage();
    if(imageMacro != null){
      this._image = imageMacro;
    }
  }
  
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
        DecisionForum.instance.selectMacroImage(_image);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Macro Image Identification'),
      ),
      body: Center(
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
          ],
        ),
      ),
    );
  }
}

