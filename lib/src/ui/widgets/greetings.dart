import 'package:amazon_clone/src/extensions/string_x.dart';
import 'package:amazon_clone/src/providers/app_provider.dart';
import 'package:amazon_clone/src/providers/user_provider.dart';
import 'package:amazon_clone/src/ui/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Greetings extends StatelessWidget {
  const Greetings({super.key});

  static const maleAvatar =
      "https://img.freepik.com/free-psd/3d-rendering-avatar_23-2150833546.jpg?w=826&t=st=1725017398~exp=1725017998~hmac=60bc4eacd8a1c5d343de3ef030f79e359f11bd5d346fa30198fd542f56625e88";

  static const femaleAvatar =
      "https://img.freepik.com/free-psd/3d-render-avatar-character_23-2150611698.jpg?w=826&t=st=1725017822~exp=1725018422~hmac=70ced823787c9203aee1d37ed0c5944844e2b5459bb34989106d907869e076fc";
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                // const
              },
              child: CircleAvatar(
                radius: 50,
                foregroundImage: NetworkImage(
                  user?.gender == "male" ? maleAvatar : femaleAvatar,
                ),
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
