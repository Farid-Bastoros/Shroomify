import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String> analyzeMushroomDescription(String description) async {
  final url = Uri.parse('https://openrouter.ai/api/v1/chat/completions');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${dotenv.env['OPENROUTER_API_KEY']}'
      // 'HTTP-Referer': 'https://yourdomain.com', // required on free tier
      // 'X-Title': 'ShroomifyTest', // optional, but helps
    },
    body: jsonEncode({
      "model": "deepseek/deepseek-chat-v3-0324:free",
      "messages": [
        {
          "role": "user",
          "content":
              "Identify the mushroom based on this description:\n$description\nReturn the species name(s), common names, and a short reasoning."
        }
      ],
    }),
  );

  print("Status Code: ${response.statusCode}");
  print("Body: ${response.body}");

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['choices'][0]['message']['content'];
  } else {
    throw Exception('LLM request failed: ${response.body}');
  }
}
