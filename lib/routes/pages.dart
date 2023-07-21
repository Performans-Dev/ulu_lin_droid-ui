import 'package:droid_ui/routes/routes.dart';
import 'package:droid_ui/ui/screens/home.dart';
import 'package:droid_ui/ui/screens/settings.dart';

import 'package:get/get.dart';

final List<GetPage> getPages = [
  GetPage(
    name: Routes.settings,
    page: () => const SettingsScreen(),
  ),
  GetPage(
    name: Routes.home,
    page: () => const HomeScreen(),
  )
];
