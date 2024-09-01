// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/injection_container.dart';
import 'package:amazon_clone/src/extensions/http_x.dart';
import 'package:amazon_clone/src/models/user/user.dart';
import 'package:amazon_clone/src/services/http_service.dart';
import 'package:amazon_clone/src/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthenticationService {
  Future<User> authenticate({required String phone}) async {
    try {
      final response = await locator<HttpService>().post(
        path: 'authenticate',
        body: {'phone': phone},
      );

      return (response.statusCode == 200 || response.statusCode == 201)
          ? User.fromMap(jsonDecode(response.body)['data'])
          : throw Exception(response.message);
      // if (response.statusCode != 200 || response.statusCode != 201) {
      //   print("response.statusCode :  ${response.statusCode}");
      //   throw Exception(response.message);
      // }
      // return User.fromMap(jsonDecode(response.body)['data']);
    } catch (e, s) {
      print("e: $e  ---  s: $s");
      rethrow;
    }
  }

  Future<User> otpLogin({required String userId, required String otp}) async {
    try {
      final response = await locator<HttpService>()
          .post(path: 'otp-login', body: {'user_id': userId, 'otp': otp});
      if (response.statusCode != HttpStatus.ok) {
        throw Exception(response.message);
      }
      await Hive.box(kAppHiveBoxKey)
          .put(kTokenKey, jsonDecode(response.body)['token']);
      final user = User.fromMap(jsonDecode(response.body)['data']);
      if (user.lastName != null && user.firstName != null) {
        await Hive.box<User>(kUserHiveBoxKey).add(user);
      }
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resendOtp({required String userId}) async {
    try {
      final response = await locator<HttpService>().post(
        path: 'otp-resend/$userId',
      );
      if (response.statusCode != HttpStatus.ok) {
        throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }
}
