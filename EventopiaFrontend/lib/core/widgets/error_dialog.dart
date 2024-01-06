import 'package:awp/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorDialog {
  static Future show(String errorMessage) {
    bool unauthorizedError = errorMessage.trim() == 'unauthorized_exception'.tr;

    return Get.dialog(
      AlertDialog(
        title: const Text(
          "Error",
          style: TextStyle(color: AppColorScheme.blue),
          textAlign: TextAlign.center,
        ),
        icon: const Icon(
          Icons.warning_rounded,
          color: AppColorScheme.red,
          size: 30,
        ),
        content: Text(
          errorMessage,
          style: const TextStyle(color: AppColorScheme.blue),
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppColorScheme.background,
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            child: const Text(
              'Ok',
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
