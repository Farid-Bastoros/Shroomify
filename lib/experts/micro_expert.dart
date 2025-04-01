import 'dart:io';
import 'package:http/http.dart' as http;

class MicroImageExpert{

  String expertUrl;

  MicroImageExpert({required this.expertUrl});

  File? _image;

  bool canUseExpert(){
    return _image != null;
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

  void setImage(File? image){
    this._image = image;
    print('Image has been set');
  }

  File? getImage(){
    return this._image;
  }


}