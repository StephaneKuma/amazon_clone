import 'package:amazon_clone/src/extensions/string_x.dart';
import 'package:amazon_clone/src/models/user/user.dart';
import 'package:amazon_clone/src/providers/app_provider.dart';
import 'package:amazon_clone/src/providers/user_provider.dart';
import 'package:amazon_clone/src/ui/helpers/constants.dart';
import 'package:amazon_clone/src/ui/widgets/user_profile_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Greetings extends StatelessWidget {
  const Greetings({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppProvider>(context).user;

    print(user);

    return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            // gradient: kAppBarGradient,
            ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserProfileImage(
              imageUrl: user!.gender == 'male' ? maleAvatar : femaleAvatar,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              "${user.firstName!.capitalize()} ${user.lastName!.capitalize()}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (user.email != null)
              Text(
                "${user.email}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            Text(
              "${user.phone}",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ));
  }
}
