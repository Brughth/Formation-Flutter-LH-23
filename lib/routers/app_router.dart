import 'package:auto_route/auto_route.dart';
import 'package:formation_lh_23/users/presentation/user_screen.dart';

import '../app_init_screen.dart';
import '../application_screen.dart';
import '../galery/presentation/gallery_screen.dart';
import '../onboarding/onboarding_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: AppInitRoute.page,
          initial: true,
        ),
        AutoRoute(page: ApplicationRoute.page, path: "/home"),
        AutoRoute(
          page: OnboardingRoute.page,
        ),
        AutoRoute(
          page: GalleryRoute.page,
        ),
        AutoRoute(
          page: UserRoute.page,
        )
      ];
}
