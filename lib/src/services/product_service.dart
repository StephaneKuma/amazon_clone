import 'dart:convert';

import 'package:amazon_clone/src/models/product.dart';
import 'package:amazon_clone/src/models/user.dart';
import 'package:amazon_clone/src/providers/user_provider.dart';
import 'package:amazon_clone/src/ui/helpers/constants.dart';
import 'package:amazon_clone/src/ui/helpers/functions.dart';
import 'package:amazon_clone/src/ui/helpers/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductService {
  Future<List<Product>> allByCategory({
    required BuildContext context,
    required String category,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> products = <Product>[];

    try {
      http.Response response = await http.get(
        Uri.parse('$kUrl/api/products?category=$category'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token,
        },
      );

      handleHttpError(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < json.decode(response.body).length; i++) {
            products.add(
              Product.fromJson(
                json.encode(
                  json.decode(response.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }

    return products;
  }

  Future<Product> dealOfTheDay({
    required BuildContext context,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    Product product = Product(
      name: '',
      description: '',
      quantity: 0,
      images: [],
      category: '',
      price: 0,
    );

    try {
      http.Response response = await http.get(
        Uri.parse('$kUrl/api/deal-of-the-day'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token,
        },
      );

      handleHttpError(
        response: response,
        context: context,
        onSuccess: () {
          product = Product.fromJson(response.body);
        },
      );
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
    return product;
  }

  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response response = await http.post(
        Uri.parse('$kUrl/api/add-to-cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
        }),
      );

      handleHttpError(
        response: response,
        context: context,
        onSuccess: () {
          User user =
              userProvider.user.copyWith(cart: jsonDecode(response.body)['cart']);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
  }

  void rate({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      http.Response response = await http.post(
        Uri.parse('$kUrl/api/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token,
        },
        body: jsonEncode({
          'id': product.id!,
          'rating': rating,
        }),
      );

      handleHttpError(
        response: response,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
  }
}
