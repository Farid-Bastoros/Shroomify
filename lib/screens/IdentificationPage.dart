import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shroomify/screens/MacroImageIdentification.dart';
import 'package:shroomify/screens/MicroImageIdentification.dart';
import 'package:shroomify/screens/TextIdentification.dart';

class Identificationpage extends StatefulWidget {
  const Identificationpage({super.key});

  @override
  State<Identificationpage> createState() => _IdentificationpageState();
}

class _IdentificationpageState extends State<Identificationpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Identify Mushroom')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Microimageidentification()),
                );
              },
              child: const Text('Select Microscopic Image'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Macroimageidentification()),
                );
              },
              child: const Text('Select Macroscopic Image'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TextIdentification()),
                );
              },
              child: const Text('Enter Text Info'),
            ),
          ],
        ),
      ),
    );

  }
}
