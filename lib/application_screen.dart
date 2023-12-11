import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:formation_lh_23/counter_whitout_bloc/counter_screen.dart';
import 'package:formation_lh_23/counter_with_cubit/presentation/counter_cubic_screen.dart';

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
            title: const Text("Counter app with bloc"),
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
          const Divider()
        ],
      ),
    );
  }
}
