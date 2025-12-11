import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/presentation/home/pages/home.dart';
import 'package:spotify/presentation/intro/pages/get_started.dart';
import 'package:spotify/service_locator.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SvgPicture.asset(AppVectors.logo, width: 250)),
    );
  }

  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 2));
    bool isLoggedIn = await sl<AuthFirebaseService>().isLoggedIn();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            isLoggedIn ? const HomePage() : const GetStarted(),
      ),
    );
  }
}
