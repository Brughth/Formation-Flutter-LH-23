import 'package:dio/dio.dart';
import 'package:formation_lh_23/counter_with_bloc/logic/bloc/counter_bloc.dart';
import 'package:formation_lh_23/counter_with_cubit/logic/cubit/counter_cubit.dart';
import 'package:formation_lh_23/galery/data/galery_repository.dart';
import 'package:formation_lh_23/galery/logic/cubit/galery_cubit.dart';
import 'package:formation_lh_23/posts_app_wiht_bloc/data/post_repository.dart';
import 'package:formation_lh_23/posts_app_wiht_bloc/logic/bloc/post_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl: "https://jsonplaceholder.typicode.com",
      ),
    ),
    instanceName: "appDio",
  );

  getIt.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl: "https://shibe.online/api",
      ),
    ),
    instanceName: "dioGalery",
  );

  getIt.registerSingleton<GalleryRepository>(
    GalleryRepository(
      dio: getIt.get<Dio>(instanceName: "dioGalery"),
    ),
  );

  getIt.registerSingleton<GalleryCubit>(
    GalleryCubit(
      repository: getIt.get<GalleryRepository>(),
    )..getImages(),
  );

  getIt.registerSingleton<PostRepository>(
    PostRepository(
      dio: getIt.get<Dio>(instanceName: "appDio"),
    ),
  );

  getIt.registerSingleton<PostBloc>(
    PostBloc(
      repository: getIt.get<PostRepository>(),
    )..add(LoadPostsEvent()),
  );

  getIt.registerSingleton<CounterBloc>(
    CounterBloc(),
  );

  getIt.registerSingleton<CounterCubit>(
    CounterCubit(),
  );
}
