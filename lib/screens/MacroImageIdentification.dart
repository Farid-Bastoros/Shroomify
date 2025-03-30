// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import '/screens/WaitingScreen.dart';

// class Macroimageidentification extends StatefulWidget {
//   @override
//   _MacroimageidentificationState createState() =>
//       _MacroimageidentificationState();
// }

// class _MacroimageidentificationState extends State<Macroimageidentification> {
//   File? _image;

  
//   Future<void> _pickImage() async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

//     if (image != null) {
//       setState(() {
//         _image = File(image.path);
//       });
//     }
//   }

  
//   void _submitImage(BuildContext context) {
//     if (_image != null) {
      
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => WaitingScreen(image: _image!),
//         ),
//       );
//     } else {
      
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Please select an image before submitting.'),
//       ));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Micro Image Identification'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _image == null
//                 ? Text('No image selected.')
//                 : Image.file(_image!),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Pick an Image'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _submitImage(context),
//               child: Text('Submit Image'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

