import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MacroImageExpert{

  String expertUrl;

  MacroImageExpert({required this.expertUrl});

  File? _image;

  bool canUseExpert(){
    return _image != null;
  }

  Future<Map<String, dynamic>> identifyMushroomImage() async {
    final bytes = await _image!.readAsBytes();
    final base64Image = base64Encode(bytes);

    final response = await http.post(
      Uri.parse(expertUrl), // confirm this endpoint with docs
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

  Future<bool> checkConnection() async {
    try {
      final response = await http.get(Uri.parse(expertUrl))
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

  void setImage(File? image){
    this._image = image;
  }

  File? getImage(){
    return this._image;
  }


}


