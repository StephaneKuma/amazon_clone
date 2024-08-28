import 'dart:io';

import 'package:amazon_clone/injection_container.dart';
import 'package:amazon_clone/src/extensions/http_x.dart';
import 'package:amazon_clone/src/models/user/user.dart';
import 'package:amazon_clone/src/services/http_service.dart';
import 'package:amazon_clone/src/utils/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserService {
  Future<User?> getUser() async {
    try {
      final user = Hive.box<User>(kUserHiveBoxKey).values.toList().firstOrNull;

      if (user == null) return null;
      final response =
          await locator<HttpService>().get(path: "users/${user.id}");
      print(response.statusCode);
      switch (response.statusCode) {
        case HttpStatus.ok:
          return User.fromJson(response.body);
        case HttpStatus.unauthorized:
          await Hive.box(kAppHiveBoxKey).delete(kTokenKey);
          await Hive.box<User>(kUserHiveBoxKey).deleteAt(0);
          return null;
        default:
          throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser({required User user}) async {
    try {
      final response = await locator<HttpService>().put(
        path: "users/${user.id}",
        body: user.toMap(),
      );
      if (response.statusCode != HttpStatus.ok) {
        throw Exception(response.message);
      }
      await Hive.box<User>(kUserHiveBoxKey).add(user);
    } catch (e) {
      rethrow;
    }
  }
}
