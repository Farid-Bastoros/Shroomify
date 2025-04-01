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
  String verbalDescription = '';

  _TextIdentificationState(){
    capDiameter = DecisionForum.instance.textExpert!.capDiameter;
    surface = DecisionForum.instance.textExpert!.surface;
    gillThickness = DecisionForum.instance.textExpert!.gillThickness;
    stemLength = DecisionForum.instance.textExpert!.stemLength;
    color = DecisionForum.instance.textExpert!.color;
    location = DecisionForum.instance.textExpert!.location;
    verbalDescription = DecisionForum.instance.textExpert!.verbalDescription;
  }

  final List<String> colors = ['','White', 'Brown', 'Yellow', 'Red', 'Gray'];
  final List<String> surfaces = ['','Smooth', 'Scaly', 'Sticky', 'Fibrillose'];
  final List<String> gillOptions = ['','Thin', 'Medium', 'Thick'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mushroom Identification'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              'Mushroom Description Form',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 20),
            // Cap Diameter
            Row(

              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Cap Diameter (cm)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Enter diameter';
                      return null;
                    },
                    onSaved: (value) {
                      capDiameter = double.tryParse(value!) ?? 0.0;
                    },
                  )
                ),
                SizedBox(width: 25),
                Expanded(child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Stem Length (cm)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter diameter';
                    return null;
                  },
                  onSaved: (value) {
                    stemLength = double.tryParse(value!) ?? 0.0;
                  },
                )
                )

              ],
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: gillThickness,
              items: gillOptions.map((g) {
                return DropdownMenuItem(value: g, child: Text(g));
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Gill Thickness',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => gillThickness = value!),
              validator: (value) => value == null ? 'Select gill thickness' : null,
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: color,
              items: colors.map((g) {
                return DropdownMenuItem(value: g, child: Text(g));
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Color',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => color = value!),
              validator: (value) => value == null ? 'Select visible color' : null,
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: surface,
              items: surfaces.map((g) {
                return DropdownMenuItem(value: g, child: Text(g));
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Surface Type',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => surface = value!),
              validator: (value) => value == null ? 'Select Surface Type' : null,
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Location Details',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Enter Location Description';
                return null;
              },
              onSaved: (value) {
                location = value!;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Verbal Description',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Enter Verbal Description';
                return null;
              },
              onSaved: (value) {
                verbalDescription = value!;
              },
            ),
            SizedBox(height: 20,),
            Center(
              child: ElevatedButton(onPressed: (){}, child: Text('Save')),
            )


            

          ],
        ),
      ),
    );
  }
}

