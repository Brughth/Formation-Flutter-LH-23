import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:formation_lh_23/counter_whitout_bloc/counter_screen.dart';
import 'package:formation_lh_23/counter_with_bloc/presentation/counter_bloc_screen.dart';
import 'package:formation_lh_23/counter_with_cubit/presentation/counter_cubic_screen.dart';
import 'package:formation_lh_23/galery/presentation/gallery_screen.dart';
import 'package:formation_lh_23/posts_app_wiht_bloc/presentation/post_screen.dart';
import 'package:formation_lh_23/routers/app_router.dart';

@RoutePage()
class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({super.key});

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        title: Text(
          "Formation Flutter LH 23",
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Counter app without bloc"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const CounterScreen(
                        title: "Counter app without bloc");
                  },
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Counter app with cubic"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const CounterCubicScreen();
                  },
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Counter app with bloc"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const CounterBlocScreen();
                  },
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Post app with bloc"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const PostScreen();
                  },
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Gallery App"),
            onTap: () {
              context.router.navigate(const GalleryRoute());
            },
          ),
        ],
      ),
    );
  }
}
