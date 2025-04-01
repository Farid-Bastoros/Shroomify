import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shroomify/screens/MacroImageIdentification.dart';
import 'package:shroomify/screens/MicroImageIdentification.dart';
import 'package:shroomify/screens/TextIdentification.dart';
import 'package:shroomify/experts/decision_forum.dart';

class Identificationpage extends StatefulWidget {
  const Identificationpage({super.key});

  @override
  State<Identificationpage> createState() => _IdentificationpageState();
}

class _IdentificationpageState extends State<Identificationpage> {


  bool imageSelectedMicroscopic()
  {
    bool? bReady = DecisionForum.instance.isMicroImageReady();
    if(bReady != null) {
      return bReady ? true : false;
    }else{
      return false;
    }
  }

  bool imageSelectedMacroscopic()
  {
    bool? bReady = DecisionForum.instance.isMacroImageReady();
    if(bReady != null) {
      return bReady ? true : false;
    }else{
      return false;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Identify Mushroom')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Microimageidentification()),
                    ).then((_) {
                      setState(() {});});
                  },
                  child: const Text('Select Microscopic Image'),
                ),
                const SizedBox(width: 10),
                if (imageSelectedMicroscopic())
                  const Icon(Icons.check_circle, color: Colors.green),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Macroimageidentification()),
                    ).then((_) {
                      setState(() {});});
                  },
                  child: const Text('Select Macroscopic Image'),
                ),
                const SizedBox(width: 10),
                if (imageSelectedMacroscopic())
                  const Icon(Icons.check_circle, color: Colors.green),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TextIdentification()),
                ).then((_){setState(() {});});
              },
              child: const Text('Enter Text Info'),
            ),
          ],
        ),
      ),
    );

  }
}
