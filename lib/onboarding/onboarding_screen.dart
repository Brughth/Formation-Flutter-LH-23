import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:formation_lh_23/application_screen.dart';
import 'package:formation_lh_23/routers/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (pageIndex == 0 || pageIndex == 1) {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          } else {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            await prefs.setBool("isFirstOpen", false);
            context.router.navigate(const ApplicationRoute());
          }
        },
        label: (pageIndex == 0 || pageIndex == 1)
            ? const Text("Next >")
            : const Text("Get Stated"),
      ),
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        controller: _pageController,
        children: [
          Container(
            color: Colors.green,
          ),
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.yellow,
          )
        ],
      ),
    );
  }
}
