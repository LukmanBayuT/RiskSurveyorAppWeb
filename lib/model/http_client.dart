import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpClient {

  Future<Map?> post(String function, Map reqJson) async {
    Map decodedResponse;
    var client = http.Client();
    try {
      //TODO fixing get app config tidak jalan!
      var url = 'www.abdaonline.com';
      var response = await client
          .post(Uri.https(url.toString(), "RiskSurveyorAPI/api/" + function), body: reqJson);

      decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

      return decodedResponse;
    } catch (exception) {
      return null;
    } finally {
      client.close();
    }
  }

  Future<Map?> get(String path) async {
    Map decodedResponse;
    var client = http.Client();
    try {
      //TODO fixing get app config tidak jalan!
      var url = 'www.abdaonline.com';
      var response = await client
          .get(Uri.https(url.toString(), path));

      decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

      return decodedResponse;
    } catch (exception) {
      return null;
    } finally {
      client.close();
    }
  }
}
