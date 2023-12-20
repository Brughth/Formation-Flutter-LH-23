import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formation_lh_23/application_screen.dart';
import 'package:formation_lh_23/counter_with_bloc/logic/bloc/counter_bloc.dart';
import 'package:formation_lh_23/counter_with_cubit/logic/cubit/counter_cubit.dart';
import 'package:formation_lh_23/posts_app_wiht_bloc/logic/bloc/post_bloc.dart';
import 'package:formation_lh_23/services_locator.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterCubit>(
            create: (context) => getIt.get<CounterCubit>()),
        BlocProvider<CounterBloc>(
            create: (context) => getIt.get<CounterBloc>()),
        BlocProvider<PostBloc>(
          create: (context) => getIt.get<PostBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blueAccent,
          ),
          useMaterial3: true,
        ),
        home: const ApplicationScreen(),
      ),
    );
  }
}
