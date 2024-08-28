import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/injection_container.dart';
import 'package:amazon_clone/src/extensions/hive_x.dart';
import 'package:amazon_clone/src/models/user/user.dart';
import 'package:amazon_clone/src/utils/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;

@lazySingleton
class HttpService {
  static const _url = "$kBaseUrl/api/$kApiVersion";
  Future<Response> get({required String path}) async {
    final headers = await _getRequestHeaders();
    return http.get(Uri.parse("$_url/$path"), headers: headers);
  }

  Future<Response> post(
      {required String path, Map<String, dynamic>? body}) async {
    final headers = await _getRequestHeaders();
    return http.post(Uri.parse("$_url/$path"),
        headers: headers, body: jsonEncode(body));
  }

  Future<Response> put(
      {required String path, Map<String, dynamic>? body}) async {
    final headers = await _getRequestHeaders();
    return http.put(
      Uri.parse("$_url/$path"),
      headers: headers,
      body: jsonEncode(body),
    );
  }

  Future<Map<String, String>> _getRequestHeaders() async {
    final token = Hive.box(kAppHiveBoxKey).get(kTokenKey);
    return <String, String>{
      HttpHeaders.contentTypeHeader: ContentType.json.value,
      HttpHeaders.acceptHeader: ContentType.json.value,
      if (token != null) HttpHeaders.authorizationHeader: 'Bearer $token',
    };
  }
}
