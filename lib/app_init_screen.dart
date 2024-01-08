import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:formation_lh_23/routers/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class AppInitScreen extends StatefulWidget {
  const AppInitScreen({super.key});

  @override
  State<AppInitScreen> createState() => _AppInitScreenState();
}

class _AppInitScreenState extends State<AppInitScreen> {
  init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getBool("isFirstOpen");

    if (result == false) {
      context.router.pushAndPopUntil(
        const LoginRoute(),
        predicate: (route) => false,
      );
    } else {
      context.router.pushAndPopUntil(
        const OnboardingRoute(),
        predicate: (route) => false,
      );
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
