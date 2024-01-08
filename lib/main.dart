import 'dart:io';
import 'package:atlas_company/src/modules/home/home_screen.dart';
import 'package:atlas_company/src/modules/login/login_screen.dart';
import 'package:atlas_company/src/modules/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/locator.dart';
import 'core/shared_prefrence_repository.dart';
import 'src/shared/styles/colors.dart';

main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<Widget> initialization() async {
  Widget nextScreen;
  bool isLoggedIn = locator.get<SharedPreferencesRepository>().getLoggedIn();
  if (isLoggedIn) {
    nextScreen = const HomeScreen();
  } else {
    nextScreen = const LoginScreen();
  }
  return nextScreen;
}

late Widget nextScreen;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: primaryColor,
        debugShowCheckedModeBanner: false,
        title: 'Atlas Company',
        theme: ThemeData(
          fontFamily: GoogleFonts.openSans().fontFamily,
          primarySwatch: Colors.orange,
        ),
        home: const SplashScreen());
  }
}
