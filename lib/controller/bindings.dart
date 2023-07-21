// 📦 Package imports:
import 'package:droid_ui/controller/app.dart';
import 'package:get/get.dart';

class AwaitBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    await Get.putAsync(() async => AppController(), permanent: true);
  }
}
