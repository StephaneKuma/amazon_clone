import 'package:amazon_clone/src/providers/user_provider.dart';
import 'package:amazon_clone/src/ui/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Greetings extends StatelessWidget {
  const Greetings({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: kAppBarGradient,
      ),
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        bottom: 10.0,
      ),
      child: RichText(
        text: TextSpan(
          text: 'Hello',
          style: const TextStyle(
            fontSize: 22.0,
            color: Colors.black,
          ),
          children: <InlineSpan>[
            TextSpan(
              text: user.name,
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
