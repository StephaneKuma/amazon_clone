import 'dart:io';

import 'package:amazon_clone/injection_container.dart';
import 'package:amazon_clone/router.dart';
import 'package:amazon_clone/src/models/user/user.dart';
import 'package:amazon_clone/src/providers/app_provider.dart';
import 'package:amazon_clone/src/providers/user_provider.dart';
import 'package:amazon_clone/src/ui/helpers/constants.dart';
import 'package:amazon_clone/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'src/ui/views/starter_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  configureDependencies();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox(kAppHiveBoxKey);
  await Hive.openBox<User>(kUserHiveBoxKey);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Afro Stand',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        colorScheme: const ColorScheme.light(
          primary: kSecondaryColor,
        ),
        fontFamily: GoogleFonts.poppins().fontFamily,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        dropdownMenuTheme: const DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(
              color: kUnselectedNavBarColor,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: kUnselectedNavBarColor,
              ),
            ),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          isDense: true,
          labelStyle: TextStyle(
            color: kUnselectedNavBarColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: kUnselectedNavBarColor,
            ),
          ),
        ),
        useMaterial3: true, // can remove this line
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const StarterView(), // AuthenticationView
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) =>
              true; // add your localhost detection logic here if you want
  }
}
