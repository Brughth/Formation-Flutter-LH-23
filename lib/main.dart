import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:formation_lh_23/counter_with_bloc/logic/bloc/counter_bloc.dart';
import 'package:formation_lh_23/counter_with_cubit/logic/cubit/counter_cubit.dart';

import 'package:formation_lh_23/posts_app_wiht_bloc/logic/bloc/post_bloc.dart';
import 'package:formation_lh_23/routers/app_router.dart';
import 'package:formation_lh_23/services_locator.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

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
      child: MaterialApp.router(
        title: 'Formation LH',
        routerConfig: _appRouter.config(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blueAccent,
          ),
          useMaterial3: true,
        ),
      ),
    );
  }
}
