import 'package:amazon_clone/src/extensions/string_x.dart';
import 'package:amazon_clone/src/providers/app_provider.dart';
import 'package:amazon_clone/src/providers/user_provider.dart';
import 'package:amazon_clone/src/ui/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Greetings extends StatelessWidget {
  const Greetings({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppProvider>(context).user;

    return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            // gradient: kAppBarGradient,
            ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                // const
              },
              child: const CircleAvatar(
                radius: 50,
                // foregroundImage: AssetImage('assets/images/Black.png'),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${user?.firstName!.capitalize()} ${user?.lastName!.capitalize()}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (user?.email != null)
                  Text(
                    "${user?.email}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        Text(
                          "${user?.phone}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 15,
                          width: 15,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        )
                      ],
                    )),
              ],
            ))
          ],
        )

        // RichText(
        //   text: TextSpan(
        //     text: 'Hello',
        //     style: const TextStyle(
        //       fontSize: 22.0,
        //       color: Colors.black,
        //     ),
        //     children: <InlineSpan>[
        //       TextSpan(
        //         text: user.name,
        //         style: const TextStyle(
        //           fontSize: 22.0,
        //           fontWeight: FontWeight.w600,
        //           color: Colors.black,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

        );
  }
}
