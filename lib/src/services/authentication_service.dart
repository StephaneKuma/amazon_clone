// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/src/models/user.dart';
import 'package:amazon_clone/src/providers/user_provider.dart';
import 'package:amazon_clone/src/ui/helpers/constants.dart';
import 'package:amazon_clone/src/ui/helpers/functions.dart';
import 'package:amazon_clone/src/ui/helpers/utils.dart';
import 'package:amazon_clone/src/ui/views/wrapper_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  void signup({
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
        cart: <dynamic>[],
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
              text: "Account created! Login with the same credentials",
            );
          });
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
  }

  void signin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$kUrl/api/signin"),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      handleHttpError(
          context: context,
          response: response,
          onSuccess: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();

            Provider.of<UserProvider>(context, listen: false)
                .setUser(user: response.body);

            await preferences.setString(
              kToken,
              json.decode(response.body)['token'],
            );

            Navigator.pushNamedAndRemoveUntil(
                context, WrapperView.name, (route) => false);
          });
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
  }

  void getCurrentUser({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString(kToken);

      if (token == null) {
        preferences.setString(kToken, '');
      }

      http.Response response = await http.post(
        Uri.parse('$kUrl/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          kToken: token!
        },
      );

      final bool responseDecoded = json.decode(response.body);

      if (responseDecoded == true) {
        http.Response userResponse = await http.get(
          Uri.parse('$kUrl/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            kToken: token
          },
        );

        UserProvider userProvider =
            Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(user: userResponse.body);
      }
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
  }
}
