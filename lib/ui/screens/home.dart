import 'package:droid_ui/controller/app.dart';
import 'package:droid_ui/routes/routes.dart';
import 'package:droid_ui/ui/components/scaffold.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(builder: (app) {
      return ScaffoldWidget(
        maskEdges: true,
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Ready",
                style: TextStyle(fontSize: 70),
              ),
              const Divider(),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => Text(app.appStateList[index]),
                itemCount: app.appStateList.length,
              ),
            ],
          ),
        ),
        right: IconButton(
          onPressed: () {
            Get.toNamed(Routes.settings);
          },
          icon: const Icon(Icons.settings),
        ),
      );
    });
  }
}
