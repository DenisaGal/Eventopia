import 'package:awp/features/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late final GlobalKey<FormState> formKey;
  late final GlobalKey<FormFieldState> emailKey;
  late final GlobalKey<FormFieldState> passwordKey;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    emailKey = GlobalKey<FormFieldState>();
    passwordKey = GlobalKey<FormFieldState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.onInit();
  }

  Future login() async {
    Get.to(() => HomePage(),
        arguments: ["99b8c4c5-520b-4d3b-879e-d1bbf03dcb52"] /*TODO user id */);
  }
}
