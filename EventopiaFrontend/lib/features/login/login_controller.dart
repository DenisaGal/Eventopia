import 'package:awp/features/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awp/core/models/user_model.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class LoginController extends GetxController {
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

  void login() async {
    final user = UserModel(
      email: emailController.text,
      password: passwordController.text,
      type: bool.tryParse(typeController.text) ?? false,
    );

    final dio = Dio();
    try {
      final response = await dio.post('https://localhost:46772/User/LoginUser',
          data: jsonEncode(user)); //46772
    } catch (e) {}

    clearForm();
  }

  void clearForm() {
    emailController.clear();
    passwordController.clear();
    typeController.clear();
  }
    //Get.offAll(HomePage());
}
