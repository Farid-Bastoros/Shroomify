import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<Map<String, dynamic>> identifyMushroomImage(File imageFile) async {
  final bytes = await imageFile.readAsBytes();
  final base64Image = base64Encode(bytes);

  final response = await http.post(
    Uri.parse('https://mushroom.kindwise.com/api/v1/identification'), // confirm this endpoint with docs
    headers: {
      'Content-Type': 'application/json',
      'Api-Key': dotenv.env['MUSHROOM_ID_API_KEY']!,
    },
    body: jsonEncode({
      'images': [base64Image],
    }),
  );

  if (response.statusCode == 201) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Image identification failed: ${response.body}');
  }
}
