import 'dart:convert';

import 'package:http/http.dart';

extension HttpX on Response {
  String get message {
    return jsonDecode(body)['message'];
  }
}
