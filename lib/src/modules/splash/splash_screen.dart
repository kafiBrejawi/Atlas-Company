import 'dart:async';
import 'package:atlas_company/src/modules/login/login_screen.dart';
import 'package:atlas_company/src/shared/components/components.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void wait() {
    Future.delayed(const Duration(seconds: 2), () async {
      navigateAndFinish(context, const LoginScreen());
    });
  }

  @override
  void initState() {
    wait();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mdw = MediaQuery.of(context).size.width;
    final mdh = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            body: Container(
                width: mdw,
                height: mdh,
                color: Colors.white,
                child: Center(
                  child: SizedBox(
                    height: mdh * 0.75,
                    width: mdw * 0.75,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                ))),
      ),
    );
  }
}
