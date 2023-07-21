import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class ScaffoldWidget extends StatelessWidget {
  final Widget? content;
  final Widget? left;
  final Widget? right;
  final bool maskEdges;
  const ScaffoldWidget({
    super.key,
    this.content,
    this.left,
    this.right,
    this.maskEdges = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: LayoutBuilder(builder: (context, c) {
          return AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(c.maxHeight / 2),
              child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: Row(children: [
                  spacer(left),
                  body,
                  spacer(right),
                ]),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget spacer(Widget? child) => Container(
        height: double.infinity,
        width: math.min(Get.width, Get.height) / 8,
        alignment: Alignment.center,
        child: child,
      );
  Widget get body => Expanded(
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: content,
            ),
            if (maskEdges)
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: double.infinity,
                  height: math.min(Get.width, Get.height) / 5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.white.withOpacity(0.005),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.2, 1],
                    ),
                  ),
                ),
              ),
            if (maskEdges)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: math.min(Get.width, Get.height) / 5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.005),
                        Colors.white,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0, 0.8],
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
}
