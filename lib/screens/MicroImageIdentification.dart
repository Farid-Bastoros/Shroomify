import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:animations/animations.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shroomify/experts/decision_forum.dart';

class Microimageidentification extends StatefulWidget {
  const Microimageidentification({super.key});

  @override
  State<Microimageidentification> createState() => _MicroimageidentificationState();
}

class _MicroimageidentificationState extends State<Microimageidentification> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  _MicroimageidentificationState(){
    File? imageMicro = DecisionForum.instance.microImageExpert?.getImage();
    if(imageMicro != null){
      this._image = imageMicro;
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _image = File(image.path);
        DecisionForum.instance.selectMicroImage(_image);

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F2FF),
      appBar: AppBar(
        title: const Text(
          'Micro Image Identification',
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: SingleChildScrollView(
            child: BounceInUp(
              duration: const Duration(seconds: 1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) =>
                        FadeScaleTransition(animation: animation, child: child),
                    child: _image == null
                        ? Icon(
                      LucideIcons.imageOff,
                      size: 100,
                      color: Colors.deepPurple.shade100,
                      key: const ValueKey('empty'),
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        _image!,
                        key: const ValueKey('image'),
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: const Icon(LucideIcons.image),
                    label: const Text('Pick from Gallery'),
                    style: _buttonStyle(),
                  ),
                  const SizedBox(height: 15),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      backgroundColor: Colors.white,
      foregroundColor: Colors.deepPurple,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    );
  }
}
