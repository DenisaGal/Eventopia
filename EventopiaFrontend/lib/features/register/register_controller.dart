import 'package:awp/features/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awp/core/constants/connection.dart';
import 'package:awp/core/models/user_model.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class RegisterController extends GetxController {
  late final GlobalKey<FormState> formKey;
  late final GlobalKey<FormFieldState> emailKey;
  late final GlobalKey<FormFieldState> passwordKey;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController typeController;

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    emailKey = GlobalKey<FormFieldState>();
    passwordKey = GlobalKey<FormFieldState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    typeController = TextEditingController();

    super.onInit();
  }

  void register() async {
    final user = UserModel(
      email: emailController.text,
      password: passwordController.text,
      type: bool.tryParse(typeController.text) ?? false,
    );

    final dio = Dio();
    try {
      final response = await dio.post('${Connection.baseUrl}/User/Create',
          data: jsonEncode(user));
      Get.offAll(HomePage());
    } catch (e) {}

    clearForm();
  }

  void clearForm() {
    emailController.clear();
    passwordController.clear();
    typeController.clear();
  }
}
