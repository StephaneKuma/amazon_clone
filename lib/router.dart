import 'package:amazon_clone/src/ui/views/authentication_view.dart';
import 'package:amazon_clone/src/ui/views/home_view.dart';
import 'package:amazon_clone/src/ui/views/wrapper_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthenticationView.name:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const AuthenticationView(),
      );

    case WrapperView.name:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const WrapperView(),
      );

    case HomeView.name:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const HomeView(),
      );

    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Error 404!! This view does not exist."),
          ),
        ),
      );
  }
}
