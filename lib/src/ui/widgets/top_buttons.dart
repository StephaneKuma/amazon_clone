import 'package:amazon_clone/src/ui/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            AccountButton(
              text: "Your Orders",
              onTap: () {},
            ),
            AccountButton(
              text: "Turn Seller",
              onTap: () {},
            ),
          ],
        ),
        Row(
          children: <Widget>[
            AccountButton(
              text: "Log Out",
              onTap: () {},
            ),
            AccountButton(
              text: "Your Wish List",
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
