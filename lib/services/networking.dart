import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final url;

  Future getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String dataWeather = response.body;

      return jsonDecode(dataWeather);
    } else {
      print(response.statusCode);
    }
  }
}
