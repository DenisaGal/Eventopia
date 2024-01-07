import 'dart:convert';

import 'package:awp/core/constants/connection.dart';
import 'package:awp/core/models/user_model.dart';
import 'package:awp/core/widgets/error_dialog.dart';
import 'package:awp/features/home/home_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  late final GlobalKey<FormState> formKey;
  late final GlobalKey<FormFieldState> emailKey;
  late final GlobalKey<FormFieldState> passwordKey;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController isOrganizerController;

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    emailKey = GlobalKey<FormFieldState>();
    passwordKey = GlobalKey<FormFieldState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    isOrganizerController = TextEditingController();

    super.onInit();
  }

  void register() async {
    final user = UserModel(
      email: emailController.text,
      password: passwordController.text,
      isOrganizer: /*bool.tryParse(typeController.text) ?? */ false,
    );

    final dio = Dio();
    try {
      final response = await dio.post('${Connection.baseUrl}/User/Create',
          data: jsonEncode(user));

      clearForm();
      Get.to(() => HomePage(), arguments: response.data);
    } catch (_) {
      await ErrorDialog.show("Failed to register.");
    }

    clearForm();
  }

  void clearForm() {
    emailController.clear();
    passwordController.clear();
    isOrganizerController.clear();
  }
}
