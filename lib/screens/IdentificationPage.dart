import 'package:flutter/material.dart';
import 'package:shroomify/experts/text_expert.dart';
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

  int textFormStatus(){
    TextExpertStatus? textExpertStatus = DecisionForum.instance.isTextExpertReady();

    if(textExpertStatus != null){
      if(textExpertStatus == TextExpertStatus.READY){
        return 1;
      }else if(textExpertStatus == TextExpertStatus.PARTIAL_READY){
        return 2;
      }
    }

    return 0;
  }

  bool oneAgentReady(){
    return imageSelectedMacroscopic() || imageSelectedMicroscopic() || textFormStatus() >= 1;
  }

  bool allAgentsReady(){
    return imageSelectedMicroscopic() && imageSelectedMicroscopic() && textFormStatus() >= 1;
  }

  bool submitDisabled(){
    if (allAgentsReady() == false && oneAgentReady() == false){
      return true;
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
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TextIdentification()),
                    ).then((_){setState(() {});});
                  },
                  child: const Text('Enter Text Info'),
                ),
                const SizedBox(width: 10),
                if (textFormStatus() == 1)
                    const Icon(Icons.check_circle, color: Colors.green),
                if (textFormStatus() == 2)
                  const Icon(Icons.check_circle, color: Colors.deepOrange,),
              ],

            ),
            SizedBox(height: 70,),
            ElevatedButton(onPressed: submitDisabled() ? null : (){
              if(allAgentsReady()){
                //TODO: start identification
              }else if(oneAgentReady()){
                //TODO: Warning, then start identification
              }
            }, child: const Text('Start Identification')
            )

          ],
        ),
      ),
    );

  }
}
