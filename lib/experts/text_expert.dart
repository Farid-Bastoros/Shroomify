import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum TextExpertStatus{
  NOT_READY,
  PARTIAL_READY,
  READY
}

class TextExpert{

  double _capDiameter = 0.0;

  String _color = '';
  String _surface = '';
  String _gillThickness = '';
  double _stemLength = 0.0;
  String _location = '';
  String _verbalDescription = '';

  String expertUrl;

  double get capDiameter => _capDiameter;

  set capDiameter(double value){
    if (value >= 0) {
      _capDiameter = value;
    } else {
      throw ArgumentError("Diameter must be non-negative");
    }
  }

  String get color => _color;

  set color(String value)
  {
    this._color = value;
  }

  String get surface => _surface;

  set surface(String value){
    this._surface = value;
  }

  String get gillThickness => _gillThickness;

  set gillThickness(String value)
  {
    this._gillThickness = value;
  }

  double get stemLength => _stemLength;

  set stemLength(double value){
    if (value >= 0) {
      _stemLength = value;
    } else {
      throw ArgumentError("Diameter must be non-negative");
    }
  }

  String get location => _location;

  set location(String value){
    this._location = value;
  }

  String get verbalDescription => _verbalDescription;

  set verbalDescription(String value){
    this._verbalDescription = value;
  }

  TextExpert({required this.expertUrl});

  Future<Map<String, dynamic>> analyzeMushroomDescription(String description) async {
    final url = Uri.parse(expertUrl);

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${dotenv.env['OPENROUTER_API_KEY']}',
      },
      body: jsonEncode({
        "model": "deepseek/deepseek-chat-v3-0324:free",
        "messages": [
          {
            "role": "user",
            "content":
            "Identify the mushroom based on this description:\n$description\nReturn the species name, edibility (Edible or Poisonous), source, and confidence score (0 to 100) in a clean format without extra sentences or markdown formatting like asterisks."
          }
        ],
      }),
    );

    print("Status Code: ${response.statusCode}");
    print("Body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final content = data['choices'][0]['message']['content'] ?? '';
      print("Content Extracted: $content");

      String cleanString(String input) => input.replaceAll('*', '').trim();

      final lines = content.split('\n');
      Map<String, String> result = {};

      for (final line in lines) {
        if (line.startsWith('Species:')) {
          result['speciesName'] =
              cleanString(line.replaceFirst('Species:', ''));
        } else if (line.startsWith('Edibility:')) {
          result['edibility'] =
              cleanString(line.replaceFirst('Edibility:', ''));
        } else if (line.startsWith('Confidence:')) {
          result['confidence'] =
              cleanString(line.replaceFirst('Confidence:', ''));
        } else if (line.startsWith('Source:')) {
          result['source'] = cleanString(line.replaceFirst('Source:', ''));
        }
      }

      double confidenceScore = double.tryParse(result['confidence'] ?? '0') ??
          0.0;
      confidenceScore = confidenceScore <= 100 ? confidenceScore : 100;

      return {
        'speciesName': result['speciesName'] ?? '',
        'edibility': result['edibility'] ?? '',
        'confidenceScore': confidenceScore,
        'source': result['source'] ?? 'LLM Response',
      };
    } else {
      return {
        'speciesName': '',
        'edibility': '',
        'confidenceScore': 0.0,
        'source': 'LLM Response Failure',
      };
    }
  }

  TextExpertStatus canUseExpert(){

    final fields = [
      capDiameter > 0.0,
      stemLength > 0.0,
      _color.isNotEmpty,
      _surface.isNotEmpty,
      _gillThickness.isNotEmpty,
      _location.isNotEmpty,
      _verbalDescription.isNotEmpty
    ];

    //all fields filled out
    if (fields.every((f) => f)) return TextExpertStatus.READY;

    //no fields filled out
    if (fields.every((f) => !f)) return TextExpertStatus.NOT_READY;

    //some fields filled out
    return TextExpertStatus.PARTIAL_READY;
  }

  Future<bool> checkConnection() async {
    try {
      final response = await http.get(Uri.parse(this.expertUrl))
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        return true; // Connected & healthy response
      } else {
        return false; // Server reachable but returned an error
      }
    } catch (e) {
      return false; // Network error, timeout, DNS failure, etc.
    }
  }



}


