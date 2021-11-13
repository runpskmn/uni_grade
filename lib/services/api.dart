import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uni_grade/models/api_result.dart';

class Api {
  static const BASE_URL = 'https://api-unigrade.herokuapp.com';

  Future<dynamic> submit(
      String endPoint,
      Map<String, dynamic> params,
      ) async {
    var url = Uri.parse('$BASE_URL/$endPoint');
    print(params.toString());
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(params),
    );

    if (response.statusCode == 200) {
      // แปลง text ที่มีรูปแบบเป็น JSON ไปเป็น Dart's data structure (List/Map)
      Map<String, dynamic> jsonBody = json.decode(response.body);
      print('RESPONSE BODY: $jsonBody');

      // แปลง Dart's data structure ไปเป็น model (POJO)
      var apiResult = ApiResult.fromJson(jsonBody);

      if (apiResult.status == 'success') {
        return apiResult.data;
      } else {
        throw apiResult.message!;
      }
    } else {
      throw 'Server connection failed!';
    }
  }

  Future<dynamic> fetch(
      String endPoint, {
        Map<String, dynamic>? queryParams,
      }) async {
    String queryString = Uri(queryParameters: queryParams).query;
    var url = Uri.parse('$BASE_URL/$endPoint?$queryString');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // แปลง text ที่มีรูปแบบเป็น JSON ไปเป็น Dart's data structure (List/Map)
      Map<String, dynamic> jsonBody = json.decode(response.body);

      print('RESPONSE BODY: $jsonBody');

      // แปลง Dart's data structure ไปเป็น model (POJO)
      var apiResult = ApiResult.fromJson(jsonBody);

      if (apiResult.status == 'ok') {
        return apiResult.data;
      } else {
        throw apiResult.message!;
      }
    } else {
      throw 'Server connection failed!';
    }
  }
}