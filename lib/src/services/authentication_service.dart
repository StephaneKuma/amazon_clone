import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import '../ui/helpers/constants.dart';
import '../ui/helpers/functions.dart';
import '../ui/helpers/utils.dart';

class AuthenticationService {
  void signupUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
      );

      http.Response response = await http.post(
        Uri.parse("$kUrl/api/signup"),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      handleHttpError(
          context: context,
          response: response,
          onSuccess: () {
            showSnackBar(
                context: context,
                text: "Account created! Login with the same credentials");
          });
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
  }
}
