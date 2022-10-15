import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'utils.dart';

void handleHttpError({
  required BuildContext context,
  required http.Response response,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(
          context: context, text: jsonDecode(response.body)['message']);
      break;
    case 500:
      showSnackBar(context: context, text: jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context: context, text: response.body);
  }
}
