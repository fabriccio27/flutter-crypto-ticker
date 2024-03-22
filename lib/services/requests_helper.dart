import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestsHelper {
  Map<String, String>? headers; 
  RequestsHelper (this.headers);

  Future getData(Uri url) async {
    http.Response response = await http.get(url, headers:headers);
    if (response.statusCode == 200) {
      String jsonData = response.body;
      return jsonDecode(jsonData);
    } else {
      print(response.statusCode);
    }
    
  }
}