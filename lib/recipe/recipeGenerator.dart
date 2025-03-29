import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String> generateRecipe(String mushroom) async {
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
              "Provide a recipe using the following mushroom: $mushroom. If you can, provide a link to a recipe containing this mushroom. Do not include aask the  user anything extra at the end of your response, just the recipe. "
        }
      ],
    }),
  );

  print("Status Code: ${response.statusCode}");
  print("Body: ${response.body}");

  if (response.statusCode == 200) {
    final decodedUtf8 = utf8.decode(response.bodyBytes);
    final data = jsonDecode(decodedUtf8);
    return data['choices'][0]['message']['content'];
  } else {
    throw Exception('LLM request failed: ${response.body}');
  }
}
