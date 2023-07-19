import 'package:droid_ui/routes/routes.dart';
import 'package:droid_ui/ui/components/scaffold.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      maskEdges: true,
      content: SingleChildScrollView(
          child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 250,
            ),
            ElevatedButton.icon(
              onPressed: () {
                Get.toNamed(Routes.settings);
              },
              icon: Icon(Icons.settings),
              label: Text("settings"),
            ),
          ],
        ),
      )),
    );
  }
}
