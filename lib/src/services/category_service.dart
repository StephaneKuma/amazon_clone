import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/src/extensions/http_x.dart';
import 'package:injectable/injectable.dart';

import '../../injection_container.dart';
import '../models/category.dart';
import 'http_service.dart';

@lazySingleton
class CategoryService {
  //
  Future<List<Category>> listOfCategories() async {
    try {
      final response = await locator<HttpService>().get(
        path: 'categories',
      );
      print(response.statusCode);
      if (response.statusCode != HttpStatus.ok) {
        print("Exception ------------");
        throw Exception(response.message);
      }
      print(jsonDecode(response.body));
      return List<Category>.from(
          (jsonDecode(response.body)).map((item) => Category.fromMap(item)));
    } catch (e, s) {
      print(s);
      rethrow;
    }
  }
}
