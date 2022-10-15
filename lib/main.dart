import 'package:amazon_clone/router.dart';
import 'package:amazon_clone/src/providers/user_provider.dart';
import 'package:amazon_clone/src/services/authentication_service.dart';
import 'package:amazon_clone/src/ui/helpers/constants.dart';
import 'package:amazon_clone/src/ui/views/authentication_view.dart';
import 'package:amazon_clone/src/ui/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthenticationService _authenticationService = AuthenticationService();

  @override
  void initState() {
    super.initState();
    _authenticationService.getCurrentUser(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        colorScheme: const ColorScheme.light(
          primary: kSecondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        useMaterial3: true, // can remove this line
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? const HomeView()
          : const AuthenticationView(),
    );
  }
}
