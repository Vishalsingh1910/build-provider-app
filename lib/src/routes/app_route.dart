import 'package:get/get.dart';
import 'package:build_provider_app/src/modules/home/home_view.dart';

class AppRoutes {
  static const String home = '/home';

  static List<GetPage> routes = [
    GetPage(
      name: home,
      page: () => const HomeView(),
    ),
  ];
}
