import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:formation_lh_23/auth/data/auth_services.dart';
import 'package:formation_lh_23/auth/logic/cubit/auth_cubit.dart';
import 'package:formation_lh_23/routers/app_router.dart';
import 'package:formation_lh_23/services_locator.dart';
import 'package:formation_lh_23/shared/theming/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'auth/data/user_model.dart';

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
      var auth = await FirebaseAuth.instance.currentUser;

      if (auth == null) {
        context.router.pushAndPopUntil(
          const LoginRoute(),
          predicate: (route) => false,
        );
      } else {
        UserModel user = await AuthService().getUser(auth.uid);
        print(user);
        getIt.get<AuthCubit>().setUSer(user);
        context.router.pushAndPopUntil(
          const ApplicationRoute(),
          predicate: (route) => false,
        );
      }
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
  Widget build(BuildContext appItitcontext) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          child: const CircularProgressIndicator(
            color: kPrimaryColor,
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
