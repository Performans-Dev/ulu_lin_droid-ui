import 'package:droid_ui/controller/bindings.dart';
import 'package:droid_ui/routes/pages.dart';
import 'package:droid_ui/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  // initialize Flutter Bindings
  WidgetsFlutterBinding.ensureInitialized();
  // initialize Controller Services
  await AwaitBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      getPages: getPages,
      initialRoute: Routes.home,
      initialBinding: AwaitBindings(),
    );
  }
}
