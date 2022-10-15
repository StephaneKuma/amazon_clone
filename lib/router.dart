import 'package:flutter/material.dart';

import 'src/ui/views/authentication_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthenticationView.name:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const AuthenticationView(),
      );
    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const Scaffold(
          body: Center(child: Text("Error 404!! This view does not exist."),),
        ),
      );
  }
}
