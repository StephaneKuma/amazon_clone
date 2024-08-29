import 'dart:async';

import 'package:amazon_clone/injection_container.dart';
import 'package:amazon_clone/src/providers/app_provider.dart';
import 'package:amazon_clone/src/services/user_service.dart';
import 'package:amazon_clone/src/ui/helpers/constants.dart';
import 'package:amazon_clone/src/ui/views/authentication_view.dart';
import 'package:amazon_clone/src/ui/views/create_account.dart';
import 'package:amazon_clone/src/ui/views/phone_number_view.dart';
import 'package:amazon_clone/src/ui/views/wrapper_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_button.dart';

class StarterView extends StatefulWidget {
  const StarterView({super.key});

  static const String name = 'starter';

  @override
  State<StarterView> createState() => _StarterViewState();
}

class _StarterViewState extends State<StarterView> {
  @override
  void initState() {
    _load();
    super.initState();
  }

  void _load() async {
    try {
      final user = await locator<UserService>().getUser();
      await Future.delayed(const Duration(milliseconds: 5));
      if (user != null && mounted) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(WrapperView.name, (_) => false);
        context.read<AppProvider>().setUser(user);
        return;
      }
      if (mounted) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(PhoneNumberView.name, (_) => false);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                // Color(0xFF291403),
                kSecondaryColor2,
                kSecondaryColor2
                // Colors.red,
              ],
            ),
          ),
        ),
        SafeArea(
            child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            // Logo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                child: SvgPicture.asset(
                  'assets/icons/logo.svg',
                  height: 80,
                ),
              ),
            ),
            const Spacer(),
            // Center Image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Image.asset('assets/images/afrstnd-img.png'),
            ),
            const SizedBox(
              height: 40,
            ),
            const Spacer(),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            //   child: CustomButton(
            //     btnColor: kPrimaryColor,
            //     text: 'Authentification',
            //     style: const TextStyle(
            //         fontWeight: FontWeight.w500,
            //         fontSize: 17,
            //         color: Colors.white),
            //     onTap: () {
            //       Navigator.pushNamedAndRemoveUntil(
            //           context, PhoneNumberView.name, (route) => false);
            //     },
            //   ),
            // )
          ],
        )),
      ],
    ));
  }
}
