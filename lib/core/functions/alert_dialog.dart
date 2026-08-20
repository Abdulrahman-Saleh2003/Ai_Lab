import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> alertDialog({
  String title = 'Alert',
  String middleText = 'Do you want exit from this app',
  VoidCallback? onPressed,
  Widget? content,
  bool withoutButton = false,
}) {
  return Get.defaultDialog(
    title: title,
    middleText: middleText,
    content: content,
    titleStyle: Theme.of(Get.context!).textTheme.headlineLarge!.copyWith(
          fontSize: 24,
        ),
    middleTextStyle: Theme.of(Get.context!).textTheme.headlineLarge!.copyWith(
          fontSize: 16,
        ),
    backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
    actions: withoutButton
        ? []
        : [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'Cancel',
              ),
            ),
            ElevatedButton(
              onPressed: onPressed ??
                  () {
                    exit(0);
                  },
              child: const Text(
                'Confirm',
              ),
            ),
          ],
  );
}
