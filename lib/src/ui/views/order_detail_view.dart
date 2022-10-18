import 'package:flutter/material.dart';

import 'package:amazon_clone/src/models/order.dart';

class OrderDetailView extends StatelessWidget {
  const OrderDetailView({
    Key? key,
    required this.order,
  }) : super(key: key);

  static const String routeName = '/order-details';
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
