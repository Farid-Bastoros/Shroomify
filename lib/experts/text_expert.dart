import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<Map<String, dynamic>> analyzeMushroomDescription(String description) async {
  final url = Uri.parse('https://openrouter.ai/api/v1/chat/completions');

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
        result['speciesName'] = cleanString(line.replaceFirst('Species:', ''));
      } else if (line.startsWith('Edibility:')) {
        result['edibility'] = cleanString(line.replaceFirst('Edibility:', ''));
      } else if (line.startsWith('Confidence:')) {
        result['confidence'] = cleanString(line.replaceFirst('Confidence:', ''));
      } else if (line.startsWith('Source:')) {
        result['source'] = cleanString(line.replaceFirst('Source:', ''));
      }
    }

    double confidenceScore = double.tryParse(result['confidence'] ?? '0') ?? 0.0;
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
