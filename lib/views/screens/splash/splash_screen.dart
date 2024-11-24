import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/helpers/preferences_helper.dart';
import 'package:mcq/views/screens/bottom_navbar/bottom_navbar_screen.dart';
import 'package:mcq/views/screens/welcome/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animationFade;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animationFade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    _animationController.forward();

    Future.delayed(const Duration(milliseconds: 2000), () {
      PreferenceHelper.getLoggedInStatus().then((isLoggedIn) {
        isLoggedIn
            ? Get.off(
                const BottomNavbarScreen(),
                transition: Transition.zoom,
              )
            : Get.off(const WelcomeScreen());
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: FadeTransition(
              opacity: _animationFade,
              child: SizedBox(
                height: 150,
                width: 150,
                child: Image.asset('assets/images/app_logo.png'),
              ),
            ),
          ),
         /* FadeTransition(
            opacity: _animationFade,
            child: const Text(
              'ExamOPD',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -1),
              end: Offset.zero,
            ).animate(_animationController),
            child: FadeTransition(
              opacity: _animationFade,
              child: const Text(
                'Make Learning Easy',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
