import 'dart:convert';

import 'package:amazon_clone/src/models/order.dart';
import 'package:amazon_clone/src/models/sales.dart';
import 'package:amazon_clone/src/providers/user_provider.dart';
import 'package:amazon_clone/src/ui/helpers/constants.dart';
import 'package:amazon_clone/src/ui/helpers/functions.dart';
import 'package:amazon_clone/src/ui/helpers/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class OrderService {
  Future<List<Order>> all({required BuildContext context}) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    List<Order> orders = <Order>[];
    try {
      http.Response response = await http.get(
        Uri.parse('$kUrl/api/orders'),
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
            orders.add(
              Order.fromJson(
                json.encode(
                  json.decode(response.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context: context, text: hashCode.toString());
    }
    return orders;
  }

  void changeStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      http.Response response = await http.post(
        Uri.parse('$kUrl/api/order/change-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token,
        },
        body: json.encode({
          'id': order.id,
          'status': status,
        }),
      );

      handleHttpError(
        response: response,
        context: context,
        onSuccess: onSuccess,
      );
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
  }

  Future<Map<String, dynamic>> earnings({required BuildContext context}) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    List<Sales> sales = <Sales>[];
    int totalEarning = 0;
    try {
      http.Response response = await http.get(
        Uri.parse('$kUrl/api/analytics'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token,
        },
      );

      handleHttpError(
        response: response,
        context: context,
        onSuccess: () {
          var decodedResponse = json.decode(response.body);
          totalEarning = decodedResponse['totalEarnings'];
          sales = [
            Sales(label: 'Mobiles', earning: decodedResponse['mobileEarnings']),
            Sales(
                label: 'Essentials',
                earning: decodedResponse['essentialEarnings']),
            Sales(label: 'Books', earning: decodedResponse['booksEarnings']),
            Sales(
                label: 'Appliances',
                earning: decodedResponse['applianceEarnings']),
            Sales(
                label: 'Fashion', earning: decodedResponse['fashionEarnings']),
          ];
        },
      );
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
    return {
      'sales': sales,
      'totalEarnings': totalEarning,
    };
  }
}
